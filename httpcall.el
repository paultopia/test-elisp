;; first test: can I just eval a sexp and get it to display.

(+ 1 1)

;; ok, running eval-last-sexp on that displays it in a little mini window in the bottom.  How do I get it to show up in the buffer?  Hmm...

;; the elisp manual includes a bunch of stuff about prefix arguments here.

(prin1 (+ 1 1) (current-buffer))2

;; that does the trick nicely!  Now let's see if I can fetch a webpage...

(prin1 (url-retrieve-synchronously "http://www.paultopia.org") (current-buffer))#<buffer  *http www.paultopia.org:80*>

;; hmm.  I appear to have put a buffer in my buffer. 

(prin1 (buffer-string (url-retrieve-synchronously "http://www.paultopia.org")) (current-buffer))

;; well that threw a wrong number of arguments error on buffer-string... and looking up the docs, it appears to just return contents of current buffer, not a buffer passed to it.

;; stack overflow to the rescue!  https://emacs.stackexchange.com/questions/696/get-content-of-a-buffer

(defun getpage (url)
  (with-current-buffer (url-retrieve-synchronously url)
    (buffer-string))) 

(prin1 (getpage "http://www.paultopia.org") (current-buffer))"HTTP/1.1 200 OK
Server: nginx
Date: Sat, 21 Oct 2017 20:18:16 GMT
Content-Type: text/html
Content-Length: 224
Connection: keep-alive
Keep-Alive: timeout=15
Last-Modified: Tue, 17 Jan 2017 01:42:28 GMT
Vary: Accept-Encoding,User-Agent
Content-Encoding: gzip
ngpass_ngall: 1
Accept-Ranges: bytes

<html><head><title>Paultopia.org: Currently Nonexistent</title></head>
<body>
I don't really use this domain anymore (except to occasionally conduct an experiment).  
<p>
You might want to check out my academic webpage, <a href=\"http://paul-gowder.com\">paul-gowder.com</a>.

</body></html>
"

;; BAM!  Got it!  
