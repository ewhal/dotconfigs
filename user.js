/* Add your desired preferences to user.js in your Firefox profile's folder */

// Turn off the new tab page, and make it about:blank
user_pref("browser.newtab.url", "/home/ewhal/dot-configs/homepage.html"); 

// Turn off Geolocation
user_pref("geo.enabled", false); 

// Override the useragent to the most common useragent

// Force installation of non-updated add-ons on Firefox 20 
user_pref("extensions.checkCompatibility.20", false); 

// Disable prefetching (preloading of pages), which lowers RAM usage
user_pref("network.prefetch-next", false); 

// Override location bar search
user_pref("keyword.URL", "https://duckduckgo.com/?q=");
//user_pref("keyword.URL", "https://startpage.com/do/search?q=");

// Enable HTTP pipelineing regularly, on SSL pages, and on proxies, respectively
user_pref("network.http.pipelining", true);
user_pref("network.http.pipelining.ssl", true);
user_pref("network.http.proxy.pipelining", true);

// Increase the amount of connections/requests Firefox will make
user_pref("network.http.pipelining.maxrequests", 64);
user_pref("network.http.max-connections", 512);
user_pref("network.http.max-persistent-connections-per-server", 32);

// Speed up the security delay when installing add-ons

// Disable tab animations
user_pref("browser.tabs.animate", false);

// Put cache on RAM
user_pref("browser.cache.disk.enable", true);
user_pref("browser.cache.memory.enable", true);

// Reduce page loading delay
user_pref("nglayout.initialpaint.delay", 0); 
user_pref("content.interrupt.parsing", true);
user_pref("content.notify.backoffcount", -1);
user_pref("content.notify.ontimer", true);
user_pref("content.switch.threshold", 2000000);

// Remove submenu slide delay
user_pref("ui.submenuDelay", 0);

// Set a "do-not-track" header to tell sites not to track browsing habits
user_pref("privacy.donottrackheader.enabled", true);

user_pref("browser.startup.homepage", "/home/ewhal/dot-configs/homepage.html");

//Disable useless features
user_pref("loop.enabled", false);
user_pref("browser.pocket.enabled", false);
user_pref("browser.devedition.theme.enabled", true);
user_pref("devtools.theme", "dark");

user_pref("plugins.hide_infobar_for_missing_plugin", true);
user_pref("social.remote-install.enabled", false);
user_pref("browser.download.useDownloadDir", false);
user_pref("browser.selfsupport.url", "");
user_pref("datareporting.healthreport.service.enabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("dom.ipc.plugins.reportCrashURL", false);
user_pref("Network.cookie.p3p", "frfrarar");
user_pref("apz.smooth_scroll_repaint_interval", 50);
user_pref("beacon.enabled", false);
user_pref("browser.cache.disk_cache_ssl", false);
user_pref("browser.cache.disk.capacity", 358400);
user_pref("browser.cache.disk.enable", false);
user_pref("browser.cache.disk.smart_size.first_run", false);
user_pref("browser.cache.disk.smart_size.use_old_max", false);
user_pref("browser.cache.frecency_experiment", 0);
user_pref("browser.cache.memory.max_entry_size", -1);
user_pref("browser.casting.enabled", false);
user_pref("browser.customizemode.tip0.shown", true);
user_pref("browser.display.auto_quality_min_font_size", 0);
user_pref("browser.display.document_color_use", 1);
user_pref("browser.geolocation.warning.infoURL", "");
user_pref("browser.migration.version", 27);
user_pref("browser.newtabpage.enhanced", false);
user_pref("browser.newtabpage.directory.ping", "");
//user_pref("browser.newtab.preload", false); //comment out if it's a local page
user_pref("browser.safebrowsing.appRepURL", "");
user_pref("browser.safebrowsing.downloads.enabled", false);
user_pref("browser.safebrowsing.downloads.remote.enabled", false);
user_pref("browser.safebrowsing.enabled", false);
user_pref("browser.safebrowsing.malware.enabled", false);
user_pref("browser.safebrowsing.updateURL", "");
user_pref("browser.search.countryCode", "US");
user_pref("browser.search.geoSpecificDefaults", false);
user_pref("browser.search.geoip.url", "");
user_pref("browser.search.hiddenOneOffs", "");
user_pref("browser.search.region", "US");
user_pref("browser.search.suggest.enabled", false);
user_pref("browser.search.useDBForOrder", true);
user_pref("browser.send_pings", true);
user_pref("browser.send_pings.require_same_host", true);
user_pref("browser.sessionstore.privacy_level_deferred", 2);
user_pref("browser.shell.checkDefaultBrowser", false);
user_pref("browser.startup.homepage_override.mstone", "ignore");
user_pref("content.max.tokenizing.time", 100000);
user_pref("content.notify.interval", 100000);
user_pref("datareporting.healthreport.service.firstRun", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("dom.battery.enabled", false);
user_pref("dom.enable_performance", false);
user_pref("dom.event.clipboardevents.enabled", false);
user_pref("dom.gamepad.enabled" false);
user_pref("dom.ipc.plugins.flash.subprocess.crashreporter.enabled", false);
user_pref("dom.mozApps.used", true);
user_pref("dom.storage.default_quota", 1024);
user_pref("experiments.activeExperiment", false);
user_pref("extensions.blocklist.enabled", false);
user_pref("extensions.pendingOperations", false);
user_pref("extensions.shownSelectionUI", true);
user_pref("extensions.ublock.popupFirewallPane", "true");
user_pref("extensions.ui.dictionary.hidden", true);
user_pref("extensions.ui.experiment.hidden", true);
user_pref("extensions.ui.locale.hidden", true);
user_pref("font.minimum-size.x-western", 12);
user_pref("font.name.monospace.x-western", "Cousine");
user_pref("font.name.sans-serif.x-western", "Arimo");
user_pref("font.name.serif.x-western", "Tinos");
user_pref("font.size.fixed.x-western", 15);
user_pref("font.size.variable.x-western", 18);
user_pref("general.appname.override", "Netscape");
user_pref("general.appversion.override", "5.0 (Windows)");
user_pref("general.buildID.override", "20150305021524");
user_pref("general.navigator.appVersion", "5.0 (Windows)");
user_pref("general.navigator.buildID", "20150305021524");
user_pref("general.navigator.geckoVersion", "36.0");
user_pref("general.navigator.platform", "Win32");
user_pref("general.navigator.system", "Windows NT 6.3; WOW64");
user_pref("general.navigator.version", "36.0");
user_pref("general.oscpu.override", "Windows NT 6.3; WOW64");
user_pref("general.platform.override", "Win32");
user_pref("general.productSub.override", "20100101");
user_pref("general.smoothScroll.durationToIntervalRatio", 100);
user_pref("general.smoothScroll.lines.durationMinMS", 100);
user_pref("general.smoothScroll.mouseWheel.durationMaxMS", 300);
user_pref("general.smoothScroll.mouseWheel.durationMinMS", 100);
user_pref("general.smoothScroll.other.durationMinMS", 100);
user_pref("general.smoothScroll.pages.durationMinMS", 100);
user_pref("general.smoothScroll.pixels.durationMinMS", 100);
user_pref("general.smoothScroll.scrollbars.durationMinMS", 100);
user_pref("general.useragent.override", "Mozilla/5.0 (Windows NT 6.1; rv:31.0) Gecko/20100101 Firefox/31.0");
user_pref("general.useragent.vendor", "");
user_pref("general.useragent.vendorSub", "");
user_pref("general.warnOnAboutConfig", false);
user_pref("geo.wifi.uri", "");
user_pref("gfx.direct3d.last_used_feature_level_idx", 0);
user_pref("gfx.font_rendering.wordcache.charlimit", 64);
user_pref("gfx.use_text_smoothing_setting", true);
user_pref("image.mem.max_decoded_image_kb", 512000);
user_pref("intl.accept_charsets", "*");
user_pref("intl.accept_languages", "en-US, en");
user_pref("intl.browser.display.use_document_fonts", 0);
user_pref("intl.charset_default", "");
user_pref("keyword.enabled", false);
user_pref("layout.css.dpi", 103);
user_pref("media.fragmented-mp4.ffmpeg.enabled", true);
user_pref("media.fragmented-mp4.gmp.enabled", true);
user_pref("media.getusermedia.screensharing.enabled", false);
user_pref("media.mediasource.ignore_codecs", true);
user_pref("media.mediasource.webm.enabled", true);
user_pref("media.navigator.enabled", false);
user_pref("media.peerconnection.enabled", false);
user_pref("media.webm.intel_decoder.enabled", true);
user_pref("media.webspeech.recognition.enable", false);
user_pref("mousewheel.min_line_scroll_amount", 25);
user_pref("network.accept-encoding", "gzip, deflate");
user_pref("network.accept.default", "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8 ");
user_pref("network.cookie.cookieBehavior", 1);
user_pref("network.cookie.lifetime.days", 1);
user_pref("network.cookie.lifetimePolicy", 3);
user_pref("network.cookie.prefsMigrated", true);
user_pref("network.dns.disablePrefetch", true);
user_pref("network.http.pipelining.aggressive", true);
user_pref("network.http.pipelining.max-optimistic-requests", 8);
user_pref("network.http.speculative-parallel-limit", 0);
user_pref("network.http.referer.spoofSource", true);
user_pref("network.http.sendSecureXSiteReferrer", false);
user_pref("network.IDN_show_punycode", true);
user_pref("network.negotiate-auth.allow-insecure-ntlm-v1", false);
user_pref("network.predictor.cleaned-up", true);
user_pref("network.predictor.enabled", false);
user_pref("network.prefetch-next", false);
user_pref("network.proxy.socks_remote_dns", true);
user_pref("nglayout.initialpaint.delay", 0);
user_pref("plugin.disable_full_page_plugin_for_types", "application/pdf");
user_pref("plugins.enumerable_names", "");
user_pref("plugins.hide_infobar_for_outdated_plugin", false);
user_pref("plugins.update.notifyUser", true);
user_pref("privacy.sanitize.migrateFx3Prefs", true);
user_pref("security.csp.experimentalEnabled", true);
user_pref("security.mixed_content.block_display_content", true);
user_pref("security.cert_pinning.enforcement_level", 2);
user_pref("security.ssl.errorReporting.enabled", false);
user_pref("security.ssl.treat_unsafe_negotiation_as_broken" true);
user_pref("security.ssl3.ecdhe_ecdsa_rc4_128_sha", false);
user_pref("security.ssl3.ecdhe_rsa_rc4_128_sha", false);
user_pref("security.ssl3.rsa_rc4_128_md5", false);
user_pref("security.ssl3.rsa_rc4_128_sha", false);
user_pref("security.xpconnect.plugin.unrestricted", false);
user_pref("security.warn_entering_weak", true);
user_pref("security.warn_viewing_mixed", true);
user_pref("services.sync.prefs.sync.browser.safebrowsing.enabled", false);
user_pref("services.sync.prefs.sync.browser.safebrowsing.malware.enabled", false);
user_pref("ui.mouse.radius.inputSource.touchOnly", false);
