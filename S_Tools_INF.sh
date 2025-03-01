#!/bin/bash

# Check if running as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Add the parser to the toolset
add_parser() {
  # Assuming the parser is named `system_parser`
  ln -s /path/to/system_parser /usr/local/bin/system_parser
}

# Add the unary decoder to the toolset
add_unary_decoder() {
  # Assuming the decoder is named `unary_decoder`
  ln -s /path/to/unary_decoder /usr/local/bin/unary_decoder
}

# Create a unified output function
unified_output() {
  local source_file=$1
  # Use the unary decoder to create a single formatted output
  unary_decoder $source_file
}

# Ensure support for multiple file types
support_multiple_types() {
  for file in "$@"; do
    case "${file##*.}" in
      c|cpp|java|html|css)
        unified_output $file
        ;;
      *)
        echo "Unsupported file type: $file"
        ;;
    esac
  done
}

# Main function
main() {
  add_parser
  add_unary_decoder

  # Process all files passed as arguments
  if [[ $# -eq 0 ]]; then
    echo "No files provided"
  else
    support_multiple_types "$@"
  fi
}

# Execute main function with all arguments
main "$@"
