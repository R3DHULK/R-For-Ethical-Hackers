# define a function to generate a random password
generate_password <- function(length = 12) {
  # define the character sets to use for the password
  chars_upper <- letters[1:26]
  chars_lower <- LETTERS[1:26]
  chars_numbers <- 0:9
  chars_special <- c("!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "-", "_", "+", "=")

  # combine the character sets into one vector
  chars <- c(chars_upper, chars_lower, chars_numbers, chars_special)

  # randomly select characters from the combined character set
  password <- sample(chars, length, replace = TRUE)

  # return the password as a string
  paste0(password, collapse = "")
}

# generate a random password
password <- generate_password()
cat("Random password:", password, "\n")
