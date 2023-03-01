library(httr)

# Prompt user for target URL
url <- readline(prompt = "Enter target URL: ")

# Send HTTP GET request to target URL and store response
res <- GET(url)

# Extract server header from response
server_header <- res$headers$server

# Print server header
print(paste("Server header:", server_header))
