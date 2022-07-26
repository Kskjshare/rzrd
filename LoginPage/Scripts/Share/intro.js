/**
 * Minified by jsDelivr using UglifyJS v3.0.24.
 * Original file: /npm/intro.js@2.8.0-alpha.1/intro.js
 * 
 * Do NOT use SRI with dynamically generated files! More information: https://www.jsdelivr.com/using-sri-with-dynamic-files
 */
!
function(t, e) {
	"object" == typeof exports ? e(exports) : "function" == typeof define && define.amd ? define(["exports"], e) : e(t)
} (this,
function(t) {
	function e(t) {
		this._targetElement = t,
		this._introItems = [],
		this._options = {
			nextLabel: "Next &rarr;",
			prevLabel: "&larr; Back",
			skipLabel: "Skip",
			doneLabel: "Done",
			hidePrev: !1,
			hideNext: !1,
			tooltipPosition: "bottom",
			tooltipClass: "",
			highlightClass: "",
			exitOnEsc: !0,
			exitOnOverlayClick: !0,
			showStepNumbers: !0,
			keyboardNavigation: !0,
			showButtons: !0,
			showBullets: !0,
			showProgress: !1,
			scrollToElement: !0,
			scrollTo: "element",
			scrollPadding: 30,
			overlayOpacity: .8,
			positionPrecedence: ["bottom", "top", "right", "left"],
			disableInteraction: !1,
			hintPosition: "top-middle",
			hintButtonLabel: "Got it",
			hintAnimation: !0
		}
	}
	function i(t) {
		var e = [],
		i = this;
		if (this._options.steps) for (var o = 0,
		r = this._options.steps.length; o < r; o++) {
			var a = n(this._options.steps[o]);
			if (a.step = e.length + 1, "string" == typeof a.element && (a.element = document.querySelector(a.element)), void 0 === a.element || null == a.element) {
				var h = document.querySelector(".introjsFloatingElement");
				null == h && ((h = document.createElement("div")).className = "introjsFloatingElement", document.body.appendChild(h)),
				a.element = h,
				a.position = "floating"
			}
			a.scrollTo = a.scrollTo || this._options.scrollTo,
			void 0 === a.disableInteraction && (a.disableInteraction = this._options.disableInteraction),
			null != a.element && e.push(a)
		} else {
			var u = t.querySelectorAll("*[data-intro]");
			if (u.length < 1) return ! 1;
			for (var o = 0,
			d = u.length; o < d; o++) if ("none" != (g = u[o]).style.display) {
				var p = parseInt(g.getAttribute("data-step"), 10),
				f = this._options.disableInteraction;
				void 0 !== g.getAttribute("data-disable-interaction") && (f = !!g.getAttribute("data-disable-interaction")),
				p > 0 && (e[p - 1] = {
					element: g,
					intro: g.getAttribute("data-intro"),
					step: parseInt(g.getAttribute("data-step"), 10),
					tooltipClass: g.getAttribute("data-tooltipClass"),
					highlightClass: g.getAttribute("data-highlightClass"),
					position: g.getAttribute("data-position") || this._options.tooltipPosition,
					scrollTo: g.getAttribute("data-scrollTo") || this._options.scrollTo,
					disableInteraction: f
				})
			}
			for (var m = 0,
			o = 0,
			d = u.length; o < d; o++) {
				var g = u[o];
				if (null == g.getAttribute("data-step")) {
					for (;;) {
						if (void 0 === e[m]) break;
						m++
					}
					f = this._options.disableInteraction;
					void 0 !== g.getAttribute("data-disable-interaction") && (f = !!g.getAttribute("data-disable-interaction")),
					e[m] = {
						element: g,
						intro: g.getAttribute("data-intro"),
						step: m + 1,
						tooltipClass: g.getAttribute("data-tooltipClass"),
						highlightClass: g.getAttribute("data-highlightClass"),
						position: g.getAttribute("data-position") || this._options.tooltipPosition,
						scrollTo: g.getAttribute("data-scrollTo") || this._options.scrollTo,
						disableInteraction: f
					}
				}
			}
		}
		for (var b = [], v = 0; v < e.length; v++) e[v] && b.push(e[v]);
		if ((e = b).sort(function(t, e) {
			return t.step - e.step
		}), i._introItems = e, x.call(i, t)) {
			l.call(i);
			t.querySelector(".introjs-skipbutton"),
			t.querySelector(".introjs-nextbutton");
			i._onKeyDown = function(e) {
				if (27 === e.keyCode && 1 == i._options.exitOnEsc) c.call(i, t);
				else if (37 === e.keyCode) s.call(i);
				else if (39 === e.keyCode) l.call(i);
				else if (13 === e.keyCode) {
					var n = e.target || e.srcElement;
					n && n.className.indexOf("introjs-prevbutton") > 0 ? s.call(i) : n && n.className.indexOf("introjs-skipbutton") > 0 ? (i._introItems.length - 1 == i._currentStep && "function" == typeof i._introCompleteCallback && i._introCompleteCallback.call(i), c.call(i, t)) : l.call(i),
					e.preventDefault ? e.preventDefault() : e.returnValue = !1
				}
			},
			i._onResize = function(t) {
				i.refresh.call(i)
			},
			window.addEventListener ? (this._options.keyboardNavigation && window.addEventListener("keydown", i._onKeyDown, !0), window.addEventListener("resize", i._onResize, !0)) : document.attachEvent && (this._options.keyboardNavigation && document.attachEvent("onkeydown", i._onKeyDown), document.attachEvent("onresize", i._onResize))
		}
		return ! 1
	}
	function n(t) {
		if (null == t || "object" != typeof t || void 0 !== t.nodeType) return t;
		var e = {};
		for (var i in t)"undefined" != typeof jQuery && t[i] instanceof jQuery ? e[i] = t[i] : e[i] = n(t[i]);
		return e
	}
	function o(t) {
		this._currentStep = t - 2,
		void 0 !== this._introItems && l.call(this)
	}
	function r(t) {
		this._currentStepNumber = t,
		void 0 !== this._introItems && l.call(this)
	}
	function l() {
		if (this._direction = "forward", void 0 !== this._currentStepNumber) for (var t = 0,
		e = this._introItems.length; t < e; t++) this._introItems[t].step === this._currentStepNumber && (this._currentStep = t - 1, this._currentStepNumber = void 0);
		if (void 0 === this._currentStep ? this._currentStep = 0 : ++this._currentStep, void 0 !== this._introBeforeChangeCallback) var i = this._introBeforeChangeCallback.call(this);
		if (!1 === i) return--this._currentStep,
		!1;
		if (this._introItems.length <= this._currentStep) return "function" == typeof this._introCompleteCallback && this._introCompleteCallback.call(this),
		void c.call(this, this._targetElement);
		var n = this._introItems[this._currentStep];
		v.call(this, n)
	}
	function s() {
		if (this._direction = "backward", 0 === this._currentStep) return ! 1;
		if (--this._currentStep, void 0 !== this._introBeforeChangeCallback) var t = this._introBeforeChangeCallback.call(this);
		if (!1 === t) return++this._currentStep,
		!1;
		var e = this._introItems[this._currentStep];
		v.call(this, e)
	}
	function a() {
		if (m.call(this, document.querySelector(".introjs-helperLayer")), m.call(this, document.querySelector(".introjs-tooltipReferenceLayer")), m.call(this, document.querySelector(".introjs-disableInteraction")), void 0 !== this._currentStep && null !== this._currentStep) {
			var t = document.querySelector(".introjs-helperNumberLayer"),
			e = document.querySelector(".introjs-arrow"),
			i = document.querySelector(".introjs-tooltip");
			h.call(this, this._introItems[this._currentStep].element, i, e, t)
		}
		return I.call(this),
		this
	}
	function c(t, e) {
		var i = !0;
		if (void 0 != this._introBeforeExitCallback && (i = this._introBeforeExitCallback.call(self)), e || !1 !== i) {
			var n = t.querySelectorAll(".introjs-overlay");
			if (n && n.length > 0) for (h = n.length - 1; h >= 0; h--) {
				var o = n[h];
				o.style.opacity = 0,
				setTimeout(function() {
					this.parentNode && this.parentNode.removeChild(this)
				}.bind(o), 500)
			}
			var r = t.querySelector(".introjs-helperLayer");
			r && r.parentNode.removeChild(r);
			var l = t.querySelector(".introjs-tooltipReferenceLayer");
			l && l.parentNode.removeChild(l);
			var s = t.querySelector(".introjs-disableInteraction");
			s && s.parentNode.removeChild(s);
			var a = document.querySelector(".introjsFloatingElement");
			a && a.parentNode.removeChild(a),
			_();
			var c = document.querySelectorAll(".introjs-fixParent");
			if (c && c.length > 0) for (var h = c.length - 1; h >= 0; h--) c[h].className = c[h].className.replace(/introjs-fixParent/g, "").replace(/^\s+|\s+$/g, "");
			window.removeEventListener ? window.removeEventListener("keydown", this._onKeyDown, !0) : document.detachEvent && document.detachEvent("onkeydown", this._onKeyDown),
			void 0 != this._introExitCallback && this._introExitCallback.call(self),
			this._currentStep = void 0
		}
	}
	function h(t, e, i, n, o) {
		var r, l, s, a, c, h = "";
		if (o = o || !1, e.style.top = null, e.style.right = null, e.style.bottom = null, e.style.left = null, e.style.marginLeft = null, e.style.marginTop = null, i.style.display = "inherit", void 0 !== n && null != n && (n.style.top = null, n.style.left = null), this._introItems[this._currentStep]) switch (r = this._introItems[this._currentStep], h = "string" == typeof r.tooltipClass ? r.tooltipClass: this._options.tooltipClass, e.className = ("introjs-tooltip " + h).replace(/^\s+|\s+$/g, ""), "floating" != (c = this._introItems[this._currentStep].position) && (c = "auto" === c ? p.call(this, t, e) : p.call(this, t, e, c)), s = D(t), l = D(e), a = S(), c) {
		case "top":
			if (i.className = "introjs-arrow bottom", o) f = 0;
			else var f = 15;
			u(s, f, l, a, e),
			e.style.bottom = s.height + 20 + "px";
			break;
		case "right":
			e.style.left = s.width + 20 + "px",
			s.top + l.height > a.height ? (i.className = "introjs-arrow left-bottom", e.style.top = "-" + (l.height - s.height - 20) + "px") : i.className = "introjs-arrow left";
			break;
		case "left":
			o || 1 != this._options.showStepNumbers || (e.style.top = "15px"),
			s.top + l.height > a.height ? (e.style.top = "-" + (l.height - s.height - 20) + "px", i.className = "introjs-arrow right-bottom") : i.className = "introjs-arrow right",
			e.style.right = s.width + 20 + "px";
			break;
		case "floating":
			i.style.display = "none",
			e.style.left = "50%",
			e.style.top = "50%",
			e.style.marginLeft = "-" + l.width / 2 + "px",
			e.style.marginTop = "-" + l.height / 2 + "px",
			void 0 !== n && null != n && (n.style.left = "-" + (l.width / 2 + 18) + "px", n.style.top = "-" + (l.height / 2 + 18) + "px");
			break;
		case "bottom-right-aligned":
			i.className = "introjs-arrow top-right";
			d(s, 0, l, e),
			e.style.top = s.height + 20 + "px";
			break;
		case "bottom-middle-aligned":
			i.className = "introjs-arrow top-middle";
			var m = s.width / 2 - l.width / 2;
			o && (m += 5),
			d(s, m, l, e) && (e.style.right = null, u(s, m, l, a, e)),
			e.style.top = s.height + 20 + "px";
			break;
		case "bottom-left-aligned":
		case "bottom":
		default:
			i.className = "introjs-arrow top",
			u(s, f = 0, l, a, e),
			e.style.top = s.height + 20 + "px"
		}
	}
	function u(t, e, i, n, o) {
		return t.left + e + i.width > n.width ? (o.style.left = n.width - i.width - t.left + "px", !1) : (o.style.left = e + "px", !0)
	}
	function d(t, e, i, n) {
		return t.left + t.width - e - i.width < 0 ? (n.style.left = -t.left + "px", !1) : (n.style.right = e + "px", !0)
	}
	function p(t, e, i) {
		var n = this._options.positionPrecedence.slice(),
		o = S(),
		r = D(e).height + 10,
		l = D(e).width + 20,
		s = D(t),
		a = "floating";
		return s.left + l > o.width || s.left + s.width / 2 - l < 0 ? (f(n, "bottom"), f(n, "top")) : (s.height + s.top + r > o.height && f(n, "bottom"), s.top - r < 0 && f(n, "top")),
		s.width + s.left + l > o.width && f(n, "right"),
		s.left - l < 0 && f(n, "left"),
		n.length > 0 && (a = n[0]),
		i && "auto" != i && n.indexOf(i) > -1 && (a = i),
		a
	}
	function f(t, e) {
		t.indexOf(e) > -1 && t.splice(t.indexOf(e), 1)
	}
	function m(t) {
		if (t) {
			if (!this._introItems[this._currentStep]) return;
			var e = this._introItems[this._currentStep],
			i = D(e.element),
			n = 10;
			E(e.element) ? t.className += " introjs-fixedTooltip": t.className = t.className.replace(" introjs-fixedTooltip", ""),
			"floating" == e.position && (n = 0),
			t.setAttribute("style", "width: " + (i.width + n) + "px; height:" + (i.height + n) + "px; top:" + (i.top - 5) + "px;left: " + (i.left - 5) + "px;")
		}
	}
	function g() {
		var t = document.querySelector(".introjs-disableInteraction");
		null === t && ((t = document.createElement("div")).className = "introjs-disableInteraction", this._targetElement.appendChild(t)),
		m.call(this, t)
	}
	function b(t) {
		t.setAttribute("role", "button"),
		t.tabIndex = 0
	}
	function v(t) {
		void 0 !== this._introChangeCallback && this._introChangeCallback.call(this, t.element);
		var e = this,
		i = document.querySelector(".introjs-helperLayer"),
		n = document.querySelector(".introjs-tooltipReferenceLayer"),
		o = "introjs-helperLayer";
		D(t.element);
		if ("string" == typeof t.highlightClass && (o += " " + t.highlightClass), "string" == typeof this._options.highlightClass && (o += " " + this._options.highlightClass), null != i) {
			var r = n.querySelector(".introjs-helperNumberLayer"),
			a = n.querySelector(".introjs-tooltiptext"),
			u = n.querySelector(".introjs-arrow"),
			d = n.querySelector(".introjs-tooltip"),
			p = n.querySelector(".introjs-skipbutton"),
			f = n.querySelector(".introjs-prevbutton"),
			v = n.querySelector(".introjs-nextbutton");
			if (i.className = o, d.style.opacity = 0, d.style.display = "none", null != r) {
				var C = this._introItems[t.step - 2 >= 0 ? t.step - 2 : 0]; (null != C && "forward" == this._direction && "floating" == C.position || "backward" == this._direction && "floating" == t.position) && (r.style.opacity = 0)
			}
			m.call(e, i),
			m.call(e, n);
			var j = document.querySelectorAll(".introjs-fixParent");
			if (j && j.length > 0) for (q = j.length - 1; q >= 0; q--) j[q].className = j[q].className.replace(/introjs-fixParent/g, "").replace(/^\s+|\s+$/g, "");
			_(),
			e._lastShowElementTimer && clearTimeout(e._lastShowElementTimer),
			e._lastShowElementTimer = setTimeout(function() {
				null != r && (r.innerHTML = t.step),
				a.innerHTML = t.intro,
				d.style.display = "block",
				h.call(e, t.element, d, u, r),
				e._options.showBullets && (n.querySelector(".introjs-bullets li > a.active").className = "", n.querySelector('.introjs-bullets li > a[data-stepnumber="' + t.step + '"]').className = "active"),
				n.querySelector(".introjs-progress .introjs-progressbar").setAttribute("style", "width:" + V.call(e) + "%;"),
				d.style.opacity = 1,
				r && (r.style.opacity = 1),
				void 0 !== p && null != p && /introjs-donebutton/gi.test(p.className) ? p.focus() : void 0 !== v && null != v && v.focus(),
				y.call(e, t.scrollTo, t, a)
			},
			350)
		} else {
			var N = document.createElement("div"),
			E = document.createElement("div"),
			S = document.createElement("div"),
			k = document.createElement("div"),
			x = document.createElement("div"),
			A = document.createElement("div"),
			L = document.createElement("div"),
			I = document.createElement("div");
			N.className = o,
			E.className = "introjs-tooltipReferenceLayer",
			m.call(e, N),
			m.call(e, E),
			this._targetElement.appendChild(N),
			this._targetElement.appendChild(E),
			S.className = "introjs-arrow",
			x.className = "introjs-tooltiptext",
			x.innerHTML = t.intro,
			A.className = "introjs-bullets",
			!1 === this._options.showBullets && (A.style.display = "none");
			for (var T = document.createElement("ul"), q = 0, P = this._introItems.length; q < P; q++) {
				var H = document.createElement("li"),
				B = document.createElement("a");
				B.onclick = function() {
					e.goToStep(this.getAttribute("data-stepnumber"))
				},
				q === t.step - 1 && (B.className = "active"),
				b(B),
				B.innerHTML = "&nbsp;",
				B.setAttribute("data-stepnumber", this._introItems[q].step),
				H.appendChild(B),
				T.appendChild(H)
			}
			A.appendChild(T),
			L.className = "introjs-progress",
			!1 === this._options.showProgress && (L.style.display = "none");
			var O = document.createElement("div");
			if (O.className = "introjs-progressbar", O.setAttribute("style", "width:" + V.call(this) + "%;"), L.appendChild(O), I.className = "introjs-tooltipbuttons", !1 === this._options.showButtons && (I.style.display = "none"), k.className = "introjs-tooltip", k.appendChild(x), k.appendChild(A), k.appendChild(L), 1 == this._options.showStepNumbers) {
				var M = document.createElement("span");
				M.className = "introjs-helperNumberLayer",
				M.innerHTML = t.step,
				E.appendChild(M)
			}
			k.appendChild(S),
			E.appendChild(k),
			(v = document.createElement("a")).onclick = function() {
				e._introItems.length - 1 != e._currentStep && l.call(e)
			},
			b(v),
			v.innerHTML = this._options.nextLabel,
			(f = document.createElement("a")).onclick = function() {
				0 != e._currentStep && s.call(e)
			},
			b(f),
			f.innerHTML = this._options.prevLabel,
			(p = document.createElement("a")).className = "introjs-button introjs-skipbutton",
			b(p),
			p.innerHTML = this._options.skipLabel,
			p.onclick = function() {
				e._introItems.length - 1 == e._currentStep && "function" == typeof e._introCompleteCallback && e._introCompleteCallback.call(e),
				c.call(e, e._targetElement)
			},
			I.appendChild(p),
			this._introItems.length > 1 && (I.appendChild(f), I.appendChild(v)),
			k.appendChild(I),
			h.call(e, t.element, k, S, M),
			y.call(this, t.scrollTo, t, k)
		}
		var R = e._targetElement.querySelector(".introjs-disableInteraction");
		R && R.parentNode.removeChild(R),
		t.disableInteraction && g.call(e),
		void 0 !== v && null != v && v.removeAttribute("tabIndex"),
		void 0 !== f && null != f && f.removeAttribute("tabIndex"),
		0 == this._currentStep && this._introItems.length > 1 ? (void 0 !== p && null != p && (p.className = "introjs-button introjs-skipbutton"), void 0 !== v && null != v && (v.className = "introjs-button introjs-nextbutton"), 1 == this._options.hidePrev ? (void 0 !== f && null != f && (f.className = "introjs-button introjs-prevbutton introjs-hidden"), void 0 !== v && null != v && (v.className += " introjs-fullbutton")) : void 0 !== f && null != f && (f.className = "introjs-button introjs-prevbutton introjs-disabled"), void 0 !== f && null != f && (f.tabIndex = "-1"), void 0 !== p && null != p && (p.innerHTML = this._options.skipLabel)) : this._introItems.length - 1 == this._currentStep || 1 == this._introItems.length ? (void 0 !== p && null != p && (p.innerHTML = this._options.doneLabel, p.className += " introjs-donebutton"), void 0 !== f && null != f && (f.className = "introjs-button introjs-prevbutton"), 1 == this._options.hideNext ? (void 0 !== v && null != v && (v.className = "introjs-button introjs-nextbutton introjs-hidden"), void 0 !== f && null != f && (f.className += " introjs-fullbutton")) : void 0 !== v && null != v && (v.className = "introjs-button introjs-nextbutton introjs-disabled"), void 0 !== v && null != v && (v.tabIndex = "-1")) : (void 0 !== p && null != p && (p.className = "introjs-button introjs-skipbutton"), void 0 !== f && null != f && (f.className = "introjs-button introjs-prevbutton"), void 0 !== v && null != v && (v.className = "introjs-button introjs-nextbutton"), void 0 !== p && null != p && (p.innerHTML = this._options.skipLabel)),
		void 0 !== v && null != v && v.focus(),
		w(t),
		void 0 !== this._introAfterChangeCallback && this._introAfterChangeCallback.call(this, t.element)
	}
	function y(t, e, i) {
		if (this._options.scrollToElement) {
			if ("tooltip" === t) n = i.getBoundingClientRect();
			else var n = e.element.getBoundingClientRect();
			if (!k(e.element)) {
				var o = S().height,
				r = n.bottom - (n.bottom - n.top);
				n.bottom;
				r < 0 || e.element.clientHeight > o ? window.scrollBy(0, n.top - (o / 2 - n.height / 2) - this._options.scrollPadding) : window.scrollBy(0, n.top - (o / 2 - n.height / 2) + this._options.scrollPadding)
			}
		}
	}
	function _() {
		for (var t = document.querySelectorAll(".introjs-showElement"), e = 0, i = t.length; e < i; e++) j(t[e], /introjs-[a-zA-Z]+/g)
	}
	function w(t) {
		if (t.element instanceof SVGElement) for (i = t.element.parentNode; null != t.element.parentNode && i.tagName && "body" !== i.tagName.toLowerCase();)"svg" === i.tagName.toLowerCase() && C(i, "introjs-showElement introjs-relativePosition"),
		i = i.parentNode;
		C(t.element, "introjs-showElement");
		var e = N(t.element, "position");
		"absolute" !== e && "relative" !== e && "fixed" !== e && C(t.element, "introjs-relativePosition");
		for (var i = t.element.parentNode; null != i && i.tagName && "body" !== i.tagName.toLowerCase();) {
			var n = N(i, "z-index"),
			o = parseFloat(N(i, "opacity")),
			r = N(i, "transform") || N(i, "-webkit-transform") || N(i, "-moz-transform") || N(i, "-ms-transform") || N(i, "-o-transform"); (/[0-9]+/.test(n) || o < 1 || "none" !== r && void 0 !== r) && (i.className += " introjs-fixParent"),
			i = i.parentNode
		}
	}
	function C(t, e) {
		if (t instanceof SVGElement) {
			var i = t.getAttribute("class") || "";
			t.setAttribute("class", i + " " + e)
		} else t.className += " " + e
	}
	function j(t, e) {
		if (t instanceof SVGElement) {
			var i = t.getAttribute("class") || "";
			t.setAttribute("class", i.replace(e, "").replace(/^\s+|\s+$/g, ""))
		} else t.className = t.className.replace(e, "").replace(/^\s+|\s+$/g, "")
	}
	function N(t, e) {
		var i = "";
		return t.currentStyle ? i = t.currentStyle[e] : document.defaultView && document.defaultView.getComputedStyle && (i = document.defaultView.getComputedStyle(t, null).getPropertyValue(e)),
		i && i.toLowerCase ? i.toLowerCase() : i
	}
	function E(t) {
		var e = t.parentNode;
		return ! (!e || "HTML" === e.nodeName) && ("fixed" == N(t, "position") || E(e))
	}
	function S() {
		if (void 0 != window.innerWidth) return {
			width: window.innerWidth,
			height: window.innerHeight
		};
		var t = document.documentElement;
		return {
			width: t.clientWidth,
			height: t.clientHeight
		}
	}
	function k(t) {
		var e = t.getBoundingClientRect();
		return e.top >= 0 && e.left >= 0 && e.bottom + 80 <= window.innerHeight && e.right <= window.innerWidth
	}
	function x(t) {
		var e = document.createElement("div"),
		i = "",
		n = this;
		if (e.className = "introjs-overlay", t.tagName && "body" !== t.tagName.toLowerCase()) {
			var o = D(t);
			o && (i += "width: " + o.width + "px; height:" + o.height + "px; top:" + o.top + "px;left: " + o.left + "px;", e.setAttribute("style", i))
		} else i += "top: 0;bottom: 0; left: 0;right: 0;position: fixed;",
		e.setAttribute("style", i);
		return t.appendChild(e),
		e.onclick = function() {
			1 == n._options.exitOnOverlayClick && c.call(n, t)
		},
		setTimeout(function() {
			i += "opacity: " + n._options.overlayOpacity.toString() + ";",
			e.setAttribute("style", i)
		},
		10),
		!0
	}
	function A() {
		var t = this._targetElement.querySelector(".introjs-hintReference");
		if (t) {
			var e = t.getAttribute("data-step");
			return t.parentNode.removeChild(t),
			e
		}
	}
	function L(t) {
		if (this._introItems = [], this._options.hints) for (var e = 0,
		i = this._options.hints.length; e < i; e++) {
			var o = n(this._options.hints[e]);
			"string" == typeof o.element && (o.element = document.querySelector(o.element)),
			o.hintPosition = o.hintPosition || this._options.hintPosition,
			o.hintAnimation = o.hintAnimation || this._options.hintAnimation,
			null != o.element && this._introItems.push(o)
		} else {
			var r = t.querySelectorAll("*[data-hint]");
			if (r.length < 1) return ! 1;
			for (var e = 0,
			i = r.length; e < i; e++) {
				var l = r[e],
				s = l.getAttribute("data-hintAnimation");
				s = s ? "true" == s: this._options.hintAnimation,
				this._introItems.push({
					element: l,
					hint: l.getAttribute("data-hint"),
					hintPosition: l.getAttribute("data-hintPosition") || this._options.hintPosition,
					hintAnimation: s,
					tooltipClass: l.getAttribute("data-tooltipClass"),
					position: l.getAttribute("data-position") || this._options.tooltipPosition
				})
			}
		}
		M.call(this),
		document.addEventListener ? (document.addEventListener("click", A.bind(this), !1), window.addEventListener("resize", I.bind(this), !0)) : document.attachEvent && (document.attachEvent("onclick", A.bind(this)), document.attachEvent("onresize", I.bind(this)))
	}
	function I() {
		for (var t = 0,
		e = this._introItems.length; t < e; t++) {
			var i = this._introItems[t];
			void 0 !== i.targetElement && R.call(this, i.hintPosition, i.element, i.targetElement)
		}
	}
	function T(t) {
		A.call(this);
		var e = this._targetElement.querySelector('.introjs-hint[data-step="' + t + '"]');
		e && (e.className += " introjs-hidehint"),
		void 0 !== this._hintCloseCallback && this._hintCloseCallback.call(this, t)
	}
	function q() {
		var t = this._targetElement.querySelectorAll(".introjs-hint");
		if (t && t.length > 0) for (var e = 0; e < t.length; e++) T.call(this, t[e].getAttribute("data-step"))
	}
	function P() {
		var t = this._targetElement.querySelectorAll(".introjs-hint");
		if (t && t.length > 0) for (var e = 0; e < t.length; e++) H.call(this, t[e].getAttribute("data-step"));
		else L.call(this, this._targetElement)
	}
	function H(t) {
		var e = this._targetElement.querySelector('.introjs-hint[data-step="' + t + '"]');
		e && (e.className = e.className.replace(/introjs\-hidehint/g, ""))
	}
	function B() {
		var t = this._targetElement.querySelectorAll(".introjs-hint");
		if (t && t.length > 0) for (var e = 0; e < t.length; e++) O.call(this, t[e].getAttribute("data-step"))
	}
	function O(t) {
		var e = this._targetElement.querySelector('.introjs-hint[data-step="' + t + '"]');
		e && e.parentNode.removeChild(e)
	}
	function M() {
		var t = this,
		e = document.querySelector(".introjs-hints");
		if (null != e) i = e;
		else {
			var i = document.createElement("div");
			i.className = "introjs-hints"
		}
		for (var n = 0,
		o = this._introItems.length; n < o; n++) {
			var r = this._introItems[n];
			if (!document.querySelector('.introjs-hint[data-step="' + n + '"]')) {
				var l = document.createElement("a");
				b(l),
				function(e, i, n) {
					e.onclick = function(e) {
						var i = e || window.event;
						i.stopPropagation && i.stopPropagation(),
						null != i.cancelBubble && (i.cancelBubble = !0),
						z.call(t, n)
					}
				} (l, 0, n),
				l.className = "introjs-hint",
				r.hintAnimation || (l.className += " introjs-hint-no-anim"),
				E(r.element) && (l.className += " introjs-fixedhint");
				var s = document.createElement("div");
				s.className = "introjs-hint-dot";
				var a = document.createElement("div");
				a.className = "introjs-hint-pulse",
				l.appendChild(s),
				l.appendChild(a),
				l.setAttribute("data-step", n),
				r.targetElement = r.element,
				r.element = l,
				R.call(this, r.hintPosition, l, r.targetElement),
				i.appendChild(l)
			}
		}
		document.body.appendChild(i),
		void 0 !== this._hintsAddedCallback && this._hintsAddedCallback.call(this)
	}
	function R(t, e, i) {
		var n = D.call(this, i);
		switch (t) {
		default:
		case "top-left":
			e.style.left = n.left + "px",
			e.style.top = n.top + "px";
			break;
		case "top-right":
			e.style.left = n.left + n.width - 20 + "px",
			e.style.top = n.top + "px";
			break;
		case "bottom-left":
			e.style.left = n.left + "px",
			e.style.top = n.top + n.height - 20 + "px";
			break;
		case "bottom-right":
			e.style.left = n.left + n.width - 20 + "px",
			e.style.top = n.top + n.height - 20 + "px";
			break;
		case "middle-left":
			e.style.left = n.left + "px",
			e.style.top = n.top + (n.height - 20) / 2 + "px";
			break;
		case "middle-right":
			e.style.left = n.left + n.width - 20 + "px",
			e.style.top = n.top + (n.height - 20) / 2 + "px";
			break;
		case "middle-middle":
			e.style.left = n.left + (n.width - 20) / 2 + "px",
			e.style.top = n.top + (n.height - 20) / 2 + "px";
			break;
		case "bottom-middle":
			e.style.left = n.left + (n.width - 20) / 2 + "px",
			e.style.top = n.top + n.height - 20 + "px";
			break;
		case "top-middle":
			e.style.left = n.left + (n.width - 20) / 2 + "px",
			e.style.top = n.top + "px"
		}
	}
	function z(t) {
		var e = document.querySelector('.introjs-hint[data-step="' + t + '"]'),
		i = this._introItems[t];
		void 0 !== this._hintClickCallback && this._hintClickCallback.call(this, e, i, t);
		var n = A.call(this);
		if (parseInt(n, 10) != t) {
			var o = document.createElement("div"),
			r = document.createElement("div"),
			l = document.createElement("div"),
			s = document.createElement("div");
			o.className = "introjs-tooltip",
			o.onclick = function(t) {
				t.stopPropagation ? t.stopPropagation() : t.cancelBubble = !0
			},
			r.className = "introjs-tooltiptext";
			var a = document.createElement("p");
			a.innerHTML = i.hint;
			var c = document.createElement("a");
			c.className = "introjs-button",
			c.innerHTML = this._options.hintButtonLabel,
			c.onclick = T.bind(this, t),
			r.appendChild(a),
			r.appendChild(c),
			l.className = "introjs-arrow",
			o.appendChild(l),
			o.appendChild(r),
			this._currentStep = e.getAttribute("data-step"),
			s.className = "introjs-tooltipReferenceLayer introjs-hintReference",
			s.setAttribute("data-step", e.getAttribute("data-step")),
			m.call(this, s),
			s.appendChild(o),
			document.body.appendChild(s),
			h.call(this, e, o, l, null, !0)
		}
	}
	function D(t) {
		var e = {},
		i = document.body,
		n = document.documentElement,
		o = window.pageYOffset || n.scrollTop || i.scrollTop,
		r = window.pageXOffset || n.scrollLeft || i.scrollLeft;
		if (t instanceof SVGElement) {
			var l = t.getBoundingClientRect();
			e.top = l.top + o,
			e.width = l.width,
			e.height = l.height,
			e.left = l.left + r
		} else {
			e.width = t.offsetWidth,
			e.height = t.offsetHeight;
			for (var s = 0,
			a = 0; t && !isNaN(t.offsetLeft) && !isNaN(t.offsetTop);) s += t.offsetLeft,
			a += t.offsetTop,
			t = t.offsetParent;
			e.top = a,
			e.left = s
		}
		return e
	}
	function V() {
		return parseInt(this._currentStep + 1, 10) / this._introItems.length * 100
	}
	function G(t, e) {
		var i = {};
		for (var n in t) i[n] = t[n];
		for (var n in e) i[n] = e[n];
		return i
	}
	var K = function(t) {
		if ("object" == typeof t) return new e(t);
		if ("string" == typeof t) {
			var i = document.querySelector(t);
			if (i) return new e(i);
			throw new Error("There is no element with given selector.")
		}
		return new e(document.body)
	};
	return K.version = "2.8.0-alpha.1",
	K.fn = e.prototype = {
		clone: function() {
			return new e(this)
		},
		setOption: function(t, e) {
			return this._options[t] = e,
			this
		},
		setOptions: function(t) {
			return this._options = G(this._options, t),
			this
		},
		start: function() {
			return i.call(this, this._targetElement),
			this
		},
		goToStep: function(t) {
			return o.call(this, t),
			this
		},
		addStep: function(t) {
			return this._options.steps || (this._options.steps = []),
			this._options.steps.push(t),
			this
		},
		addSteps: function(t) {
			if (t.length) {
				for (var e = 0; e < t.length; e++) this.addStep(t[e]);
				return this
			}
		},
		goToStepNumber: function(t) {
			return r.call(this, t),
			this
		},
		nextStep: function() {
			return l.call(this),
			this
		},
		previousStep: function() {
			return s.call(this),
			this
		},
		exit: function(t) {
			return c.call(this, this._targetElement, t),
			this
		},
		refresh: function() {
			return a.call(this),
			this
		},
		onbeforechange: function(t) {
			if ("function" != typeof t) throw new Error("Provided callback for onbeforechange was not a function");
			return this._introBeforeChangeCallback = t,
			this
		},
		onchange: function(t) {
			if ("function" != typeof t) throw new Error("Provided callback for onchange was not a function.");
			return this._introChangeCallback = t,
			this
		},
		onafterchange: function(t) {
			if ("function" != typeof t) throw new Error("Provided callback for onafterchange was not a function");
			return this._introAfterChangeCallback = t,
			this
		},
		oncomplete: function(t) {
			if ("function" != typeof t) throw new Error("Provided callback for oncomplete was not a function.");
			return this._introCompleteCallback = t,
			this
		},
		onhintsadded: function(t) {
			if ("function" != typeof t) throw new Error("Provided callback for onhintsadded was not a function.");
			return this._hintsAddedCallback = t,
			this
		},
		onhintclick: function(t) {
			if ("function" != typeof t) throw new Error("Provided callback for onhintclick was not a function.");
			return this._hintClickCallback = t,
			this
		},
		onhintclose: function(t) {
			if ("function" != typeof t) throw new Error("Provided callback for onhintclose was not a function.");
			return this._hintCloseCallback = t,
			this
		},
		onexit: function(t) {
			if ("function" != typeof t) throw new Error("Provided callback for onexit was not a function.");
			return this._introExitCallback = t,
			this
		},
		onbeforeexit: function(t) {
			if ("function" != typeof t) throw new Error("Provided callback for onbeforeexit was not a function.");
			return this._introBeforeExitCallback = t,
			this
		},
		addHints: function() {
			return L.call(this, this._targetElement),
			this
		},
		hideHint: function(t) {
			return T.call(this, t),
			this
		},
		hideHints: function() {
			return q.call(this),
			this
		},
		showHint: function(t) {
			return H.call(this, t),
			this
		},
		showHints: function() {
			return P.call(this),
			this
		},
		removeHints: function() {
			return B.call(this),
			this
		},
		removeHint: function(t) {
			return O.call(this, t),
			this
		},
		showHintDialog: function(t) {
			return z.call(this, t),
			this
		}
	},
	t.introJs = K,
	K
});
//# sourceMappingURL=/sm/64dde126889a9f4a0e7b7291caae48e7aae87f9898df58f38e40740623d872bc.map
