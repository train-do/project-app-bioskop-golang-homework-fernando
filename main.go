package main

import (
	"log"
	"net/http"

	"github.com/train-do/project-app-bioskop-golang-homework-fernando/router"
)

func main() {
	router := router.RouterAPI()
	log.Println("Starting server on port 8080...")
	log.Fatal(http.ListenAndServe(":8080", router))
}
