#####我们在linux下面可以使用下面的命令来生成一对测试的公钥和私钥文件。
    openssl genrsa -out key.pem 2048
    openssl req -new -x509 -key key.pem -out cert.pem -days 3650
    
    
#####然后我们把cert.key和key.pem到拷贝到一个目录https_demo下面，然后再在这个目录下面创建一个simple_https.go文件，代码如下：

<pre><code>
package main
 
import (
    "io"
    "log"
    "net/http"
)
 
func helloHandler(w http.ResponseWriter, r *http.Request) {
    io.WriteString(w, "hello world!")
}
 
func main() {
    http.HandleFunc("/hello", helloHandler)
    err := http.ListenAndServeTLS(":8080", "cert.pem", "key.pem", nil)
    if err != nil {
        log.Fatal("ListenAndServeTLS:", err.Error())
    }
}
</code></pre>
