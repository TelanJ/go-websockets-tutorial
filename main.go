package main

import (
	"flag"
	"fmt"
	"log"
	"net/http"
)

func main() {

	versionFlag := flag.Bool("version", false, "Version")
	flag.Parse()

	if *versionFlag {
		fmt.Println("Git Commit:", GitCommit)
		fmt.Println("Version:", Version)
		if VersionPrerelease != "" {
			fmt.Println("Version PreRelease:", VersionPrerelease)
		}
		return
	}

	router := NewRouter()
	log.Fatal(http.ListenAndServe(":8080", router))
}
