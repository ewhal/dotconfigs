/* Add your desired preferences to user.js in your Firefox profile's folder */

// Turn off the new tab page, and make it about:blank
user_pref("browser.newtab.url", "/home/ewhal/dot-configs/homepage.html"); 

// Turn off Geolocation
user_pref("geo.enabled", false); 
user_pref("geo.wifi.uri", "");

// Override the useragent to the most common useragent
user_pref("general.appname.override", "Netscape");
user_pref("general.appversion.override", "5.0 (Windows)");
user_pref("general.buildID.override", "20100101");
user_pref("general.oscpu.override", "Windows NT 6.1");
user_pref("general.platform.override", "Win32");
user_pref("general.productSub.override", "20100101");
user_pref("general.useragent.override", "Mozilla/5.0 (Windows NT 6.1; rv:38.0) Gecko/20100101 Firefox/38.0");
user_pref("general.useragent.vendor", "");
user_pref("general.useragent.vendorSub", "");

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
user_pref("content.max.tokenizing.time", 100000);
user_pref("content.notify.backoffcount", -1);
user_pref("content.notify.interval", 100000);
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

user_pref("media.navigator.enabled", false);
user_pref("media.peerconnection.enabled", false);
user_pref("network.cookie.cookieBehavior", 1);
user_pref("plugins.hide_infobar_for_missing_plugin", true);
user_pref("social.remote-install.enabled", false);
user_pref("browser.download.useDownloadDir", false);
user_pref("browser.newtabpage.enabled", false);
user_pref("browser.safebrowsing.downloads.enabled", false);
user_pref("browser.safebrowsing.enabled", false);
user_pref("browser.safebrowsing.malware.enabled", false);
user_pref("browser.search.geoSpecificDefaults", false);
user_pref("browser.selfsupport.url", "");
user_pref("datareporting.healthreport.service.enabled", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("dom.ipc.plugins.reportCrashURL", false);
