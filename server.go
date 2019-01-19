package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"stock-microsrvc/routers"
)

func main() {

	port, ok := os.LookupEnv("STOCK_PORT")
	if !ok {
		port = "8080"
	}

	router := routers.NewRouter()
	fmt.Printf("Server running on port %v\n", port)
	log.Fatal(http.ListenAndServe(":"+port, router))
}
