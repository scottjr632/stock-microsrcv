package main

import (
	"fmt"
	"net/http"
	"strings"
)

func sayHello(w http.ResponseWriter, r *http.Request) {
	message := r.URL.Path
	message = strings.TrimPrefix(message, "/")
	message = "Hello " + message
	w.Write([]byte(message))
	fmt.Println(r.RemoteAddr)
}

func anotherFunc(w http.ResponseWriter, r *http.Request) {
	message := r.URL.Path
	message = strings.TrimPrefix(message, "/")
	message = "Hello from another func" + message
	w.Write([]byte(message))
	fmt.Println(r.RemoteAddr)
}

func test() {
	http.HandleFunc("/", sayHello)
	http.HandleFunc("/another", anotherFunc)
	if err := http.ListenAndServe(":8080", nil); err != nil {
		panic(err)
	}
}
