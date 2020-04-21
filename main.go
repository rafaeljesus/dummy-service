package main

import (
	"io"
	"log"
	"net/http"
	"os"
)

func main() {
	mux := http.NewServeMux()
	log := log.New(os.Stdout, "web ", log.LstdFlags)

	mux.HandleFunc("/v1/healthz", func(w http.ResponseWriter, r *http.Request) {
		log.Println("[dummy-service] request to healthz received")

		w.WriteHeader(http.StatusOK)
		w.Header().Set("Content-Type", "application/json")

		io.WriteString(w, `{"alive": true}`)
	})

	http.ListenAndServe(":8080", mux)
}
