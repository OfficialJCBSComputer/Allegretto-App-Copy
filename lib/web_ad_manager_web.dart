import 'dart:ui_web' as ui;
import 'dart:js_interop';
import 'package:web/web.dart' as html;

void registerWebAdView({String? pubId, String? slotId}) {
  // Clean Publisher ID: Extract just the 16 digits
  String rawPub = pubId ?? "5878584013742794";
  RegExp reg = RegExp(r'(\d{16})');
  var match = reg.firstMatch(rawPub);
  String cleanPub = match != null ? match.group(1)! : "5878584013742794";
  final String effectivePubId = 'ca-pub-$cleanPub';
  
  // Clean Slot ID: Extract just digits
  String rawSlot = slotId ?? "6311371130";
  String effectiveSlotId = rawSlot.replaceAll(RegExp(r'[^0-9]'), '');

  _injectAdSenseScript(effectivePubId);

  // ignore: undefined_prefixed_name
  ui.platformViewRegistry.registerViewFactory(
    'ad-view-type',
    (int viewId) {
      final html.HTMLDivElement element = html.document.createElement('div') as html.HTMLDivElement;
      element.style.width = '100%';
      element.style.height = '100%';
      element.style.display = 'flex';
      element.style.justifyContent = 'center';
      element.style.alignItems = 'center';
      element.style.overflow = 'hidden';
      
      element.innerHTML = '''
        <ins class="adsbygoogle"
             style="display:inline-block;width:320px;height:50px"
             data-ad-client="$effectivePubId"
             data-ad-slot="$effectiveSlotId"></ins>
        <script>
             try {
                (adsbygoogle = window.adsbygoogle || []).push({});
             } catch (e) { console.error("AdSense Error", e); }
        </script>
      '''.toJS;

      return element;
    },
  );
}

void _injectAdSenseScript(String pubId) {
  final scripts = html.document.querySelectorAll('script');
  bool exists = false;
  for (int i = 0; i < scripts.length; i++) {
    final s = scripts.item(i) as html.HTMLScriptElement;
    if (s.src.contains('adsbygoogle.js')) { exists = true; break; }
  }
  if (!exists) {
    final script = html.document.createElement('script') as html.HTMLScriptElement;
    script.async = true;
    script.src = "https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=$pubId";
    script.setAttribute('crossorigin', 'anonymous');
    html.document.head?.appendChild(script);
  }
}

void registerWebIframe(String viewType, String url) {
  // ignore: undefined_prefixed_name
  ui.platformViewRegistry.registerViewFactory(viewType, (int viewId) {
    final html.HTMLIFrameElement iframe = html.document.createElement('iframe') as html.HTMLIFrameElement;
    iframe.src = url;
    iframe.style.width = '100%';
    iframe.style.height = '100%';
    iframe.style.border = 'none';
    return iframe;
  });
}

void downloadWebFile(String url) {
  final anchor = html.document.createElement('a') as html.HTMLAnchorElement;
  anchor.href = url;
  anchor.download = url.split('/').last;
  anchor.click();
}
