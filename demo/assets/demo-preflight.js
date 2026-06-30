(function () {
  if (window.__ttDemoPreflightInstalled) return;
  window.__ttDemoPreflightInstalled = true;

  function isTripTogetherServerUrl(href) {
    var value = String(href || '');
    if (/^\/TripTogether(?:\/|$)/.test(value)) return true;
    try {
      var url = new URL(value, window.location.href);
      return /^\/TripTogether(?:\/|$)/.test(url.pathname);
    } catch (e) {
      return false;
    }
  }

  function isLocalServerPath(url) {
    return isTripTogetherServerUrl(url) || /^\/(?!\/)/.test(String(url || ''));
  }

  function demoPayload() {
    return JSON.stringify({
      demo: true,
      success: true,
      message: 'Demo mode',
      data: [],
      list: [],
      content: []
    });
  }

  try {
    var nativeReplaceState = history.replaceState;
    var nativePushState = history.pushState;
    history.replaceState = function (state, title, url) {
      if (typeof url === 'string' && isTripTogetherServerUrl(url)) return;
      return nativeReplaceState.apply(history, arguments);
    };
    history.pushState = function (state, title, url) {
      if (typeof url === 'string' && isTripTogetherServerUrl(url)) return;
      return nativePushState.apply(history, arguments);
    };
  } catch (e) {}

  if (window.fetch) {
    var nativeFetch = window.fetch;
    window.fetch = function (input) {
      var url = (typeof input === 'string') ? input : (input && input.url) || '';
      if (isLocalServerPath(url)) {
        return Promise.resolve(new Response(demoPayload(), {
          status: 200,
          headers: { 'Content-Type': 'application/json' }
        }));
      }
      return nativeFetch.apply(this, arguments);
    };
  }

  if (window.XMLHttpRequest) {
    var nativeOpen = XMLHttpRequest.prototype.open;
    var nativeSend = XMLHttpRequest.prototype.send;
    XMLHttpRequest.prototype.open = function (method, url) {
      this.__ttDemoPreflightUrl = url || '';
      return nativeOpen.apply(this, arguments);
    };
    XMLHttpRequest.prototype.send = function () {
      if (isLocalServerPath(this.__ttDemoPreflightUrl || '')) {
        var self = this;
        setTimeout(function () {
          Object.defineProperty(self, 'readyState', { value: 4, configurable: true });
          Object.defineProperty(self, 'status', { value: 200, configurable: true });
          Object.defineProperty(self, 'responseText', { value: demoPayload(), configurable: true });
          Object.defineProperty(self, 'response', { value: demoPayload(), configurable: true });
          if (typeof self.onreadystatechange === 'function') self.onreadystatechange();
          if (typeof self.onload === 'function') self.onload();
        }, 0);
        return;
      }
      return nativeSend.apply(this, arguments);
    };
  }

  if (window.EventSource) {
    var NativeEventSource = window.EventSource;
    function DemoEventSource(url, config) {
      var value = String(url || '');
      if (!isLocalServerPath(value)) return new NativeEventSource(url, config);
      this.url = value;
      this.withCredentials = !!(config && config.withCredentials);
      this.readyState = DemoEventSource.OPEN;
      this.__listeners = {};
      var self = this;
      setTimeout(function () { self.__emit('open', { type: 'open' }); }, 0);
    }
    DemoEventSource.CONNECTING = 0;
    DemoEventSource.OPEN = 1;
    DemoEventSource.CLOSED = 2;
    DemoEventSource.prototype.addEventListener = function (type, handler) {
      if (!handler) return;
      (this.__listeners[type] || (this.__listeners[type] = [])).push(handler);
    };
    DemoEventSource.prototype.removeEventListener = function (type, handler) {
      var list = this.__listeners[type] || [];
      this.__listeners[type] = list.filter(function (fn) { return fn !== handler; });
    };
    DemoEventSource.prototype.close = function () {
      this.readyState = DemoEventSource.CLOSED;
    };
    DemoEventSource.prototype.__emit = function (type, event) {
      var list = this.__listeners[type] || [];
      for (var i = 0; i < list.length; i++) {
        try { list[i].call(this, event); } catch (e) {}
      }
      var prop = this['on' + type];
      if (typeof prop === 'function') {
        try { prop.call(this, event); } catch (e) {}
      }
    };
    window.EventSource = DemoEventSource;
  }
})();
