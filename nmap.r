library(pingr)

nmap_scan <- function(ip_prefix) {
  hosts <- c()
  for (i in 1:255) {
    ip <- paste(ip_prefix, i, sep = ".")
    result <- ping(ip, timeout = 1, verbose = FALSE)
    if (result$received == 1) {
      hosts <- c(hosts, ip)
    }
  }
  return(hosts)
}

# to run this tool type `nmap_scan("192.168.0")`
