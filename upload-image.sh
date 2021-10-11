# configuration
bucket=assets-images-hosting-bucket-163qe05haxli4
max_age=31536000

# arguments
path="${1}"
prefix="${2}"

# computed
checksum=(
	$(
		sha512sum \
			-- \
			"${path}" \
			#
	)
)
content_type="$(
	file \
		--brief \
		--mime \
		-- \
		"${path}" \
		#
)"
filename="${path##*/}"
basename="${filename%%.*}"
extension="${filename#*.}"
key="${prefix}/${basename}-${checksum}.${extension}"

aws s3api put-object \
	--body "${path}" \
	--bucket "${bucket}" \
	--key "${key}" \
	--cache-control "max-age=${max_age},public" \
	--content-type "${content_type}" \
	#
