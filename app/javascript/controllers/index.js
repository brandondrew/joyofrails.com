// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from './application';

import CodeExample from './code-example';
import ClipboardCopy from './clipboard-copy';
import Darkmode from './darkmode';
import Flash from './flash';

import PwaInstallation from './pwa/installation';
import PwaWebPushSubscription from './pwa/web-push-subscription';
import PwaWebPushDemo from './pwa/web-push-demo';

import AnalyticsCustomEvent from './analytics/custom-event';
import TableOfContents from './table-of-contents';

import FrameForm from './forms/frame';
import SyntaxHighlightPreview from './syntax-highlight/preview';
import SnippetPreview from './snippets/preview';
import SnippetEditor from './snippets/editor';
import SnippetScreenshot from './snippets/screenshot';

application.register('analytics', AnalyticsCustomEvent);
application.register('code-example', CodeExample);
application.register('clipboard-copy', ClipboardCopy);
application.register('darkmode', Darkmode);
application.register('flash', Flash);

application.register('pwa-installation', PwaInstallation);
application.register('pwa-web-push-subscription', PwaWebPushSubscription);
application.register('pwa-web-push-demo', PwaWebPushDemo);
application.register('table-of-contents', TableOfContents);

application.register('frame-form', FrameForm);
application.register('syntax-highlight-preview', SyntaxHighlightPreview);

application.register('snippet-preview', SnippetPreview);
application.register('snippet-editor', SnippetEditor);
application.register('snippet-screenshot', SnippetScreenshot);
