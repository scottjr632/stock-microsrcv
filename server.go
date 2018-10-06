package main

import (
	"fmt"
	"log"
	"net/http"
	"stock-microsrvc/routers"
)

func main() {

	port := ":8080"

	router := routers.NewRouter()
	fmt.Printf("Server running on port %v\n", port)
	log.Fatal(http.ListenAndServe(port, router))
}
