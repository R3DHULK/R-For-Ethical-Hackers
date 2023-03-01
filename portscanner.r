# prompt the user for the host and range of ports to scan
host <- readline(" [*] Enter the host to scan: ")
port_range <- readline(" [*] Enter the range of ports to scan (e.g. '1-1024'): ")

# parse the port range input
port_range <- as.integer(strsplit(port_range, "-")[[1]])
port_range <- port_range[1]:port_range[2]

# create a function to check if a port is open
check_port <- function(port) {
  conn <- socketConnection(host = host, port = port, server = FALSE, timeout = 2)
  if(class(conn) == "socketConnection") {
    close(conn)
    return(TRUE)
  } else {
    return(FALSE)
  }
}

# scan the ports and print the results
cat(" [*] Scanning ports on", host, "...\n")
for(port in port_range) {
  if(check_port(port)) {
    cat(" [+] Port", port, "is open.\n")
  } else {
    cat(" [-] Port", port, "is closed.\n")
  }
}
cat(" [*] Scan complete.\n")
