# read-only
declare -rA extension2mime=(
	[eot]=application/vnd.ms-fontobject
	[otf]=font/otf
	[ttf]=font/ttf
	[woff]=font/woff
	[woff2]=font/woff2
)

# configuration
bucket=djsp-webfonts
max_age=7776000

# arguments
key="${2}"
path="${1}"

# computed
filename="${path##*/}"
extension="${filename##*.}"
content_type="${extension2mime[${extension}]}"

aws s3api put-object \
	--body "${path}" \
	--bucket "${bucket}" \
	--key "${key}" \
	--cache-control "max-age=${max_age},public" \
	--content-type "${content_type}" \
	#
