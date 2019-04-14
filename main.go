package main

import "stock-microsrvc-iris/server"

func main() {

	s := server.Build()
	s.Run()

}
