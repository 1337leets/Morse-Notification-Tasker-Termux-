#!/data/data/com.termux/files/usr/bin/bash

termux-wake-lock

message="$1 $2"

# Morse kod tablosu
declare -A morse
morse[A]=".-"  ; morse[B]="-..."
morse[C]="-.-."; morse[D]="-.."
morse[E]=".";   morse[F]="..-."
morse[G]="--."; morse[H]="...."
morse[I]="..";  morse[J]=".---"
morse[K]="-.-"; morse[L]=".-.."
morse[M]="--";  morse[N]="-."
morse[O]="---"; morse[P]=".--."
morse[Q]="--.-";morse[R]=".-."
morse[S]="..."; morse[T]="-"
morse[U]="..-"; morse[V]="...-"
morse[W]=".--"; morse[X]="-..-"
morse[Y]="-.--";morse[Z]="--.."
morse[0]="-----"; morse[1]=".----"
morse[2]="..---"; morse[3]="...--"
morse[4]="....-"; morse[5]="....."
morse[6]="-...."; morse[7]="--..."
morse[8]="---.."; morse[9]="----."

# Türkçe karakterleri normalleştir
message=$(printf "%s" "$message" | sed 's/[çÇ]/c/g; s/[ğĞ]/g/g; s/[ıİ]/i/g; s/[İ]/I/g; s/[öÖ]/o/g; s/[şŞ]/s/g; s/[üÜ]/u/g')

# Mesajı büyük harfe çevir
msg_upper=$(echo "$message" | tr '[:lower:]' '[:upper:]')

# Her karakteri titreştir
for ((i=0; i<${#msg_upper}; i++)); do
    char="${msg_upper:$i:1}"
    code="${morse[$char]}"
    if [[ -n "$code" ]]; then
        for ((j=0; j<${#code}; j++)); do
            symbol="${code:$j:1}"
            if [[ "$symbol" == "." ]]; then
                termux-vibrate -d 100
            elif [[ "$symbol" == "-" ]]; then
                termux-vibrate -d 300
            fi
            sleep 0.2
        done
        sleep 0.5
    else
        sleep 1
    fi
done

termux-wake-unlock

exit 0
