ascii_art='
     ____.             .__    ________      .__       ___.                        
    |    | ____   ____ |  |  /  _____/______|__| _____\_ |__   ___________  ____  
    |    |/  _ \_/ __ \|  | /   \  __\_  __ \  |/     \| __ \_/ __ \_  __ \/ ___\ 
/\__|    (  <_> )  ___/|  |_\    \_\  \  | \/  |  Y Y  \ \_\ \  ___/|  | \/ /_/  >
\________|\____/ \___  >____/\______  /__|  |__|__|_|  /___  /\___  >__|  \___  / 
                     \/             \/               \/    \/     \/     /_____/  
'

# Define the color gradient (shades of cyan and blue)
colors=(
  '\033[38;5;81m' # Cyan
  '\033[38;5;75m' # Light Blue
  '\033[38;5;69m' # Sky Blue
  '\033[38;5;63m' # Dodger Blue
  '\033[38;5;57m' # Deep Sky Blue
  '\033[38;5;51m' # Cornflower Blue
  '\033[38;5;45m' # Royal Blue
)

# Split the ASCII art into lines
IFS=$'\n' read -rd '' -a lines <<<"$ascii_art"

# Print each line with the corresponding color
for i in "${!lines[@]}"; do
  color_index=$((i % ${#colors[@]}))
  echo -e "${colors[color_index]}${lines[i]}"
done
