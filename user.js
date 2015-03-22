/* Add your desired preferences to user.js in your Firefox profile's folder */

// Turn off the new tab page, and make it about:blank
user_pref("browser.newtab.url", "/home/ewhal4/Git/dot-configs/homepage.html"); 

// Turn off Geolocation
user_pref("geo.enabled", false); 

// Override the useragent to the most common useragent
user_pref("general.useragent.override", "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:20.0) Gecko/20100101 Firefox/20.0"); 

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
user_pref("browser.cache.disk.enable", false);
user_pref("browser.cache.memory.enable", true
user_pref("browser.cache.memory.max_entry_size", -1);

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

user_pref("browser.startup.homepage", "/home/ewhal4/Git/dot-configs/homepage.html");

