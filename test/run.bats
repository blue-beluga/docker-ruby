#!/usr/bin/env bats

setup() {
  docker history "$REGISTRY/$REPOSITORY:$TAG" >/dev/null 2>&1
  export IMG="$REGISTRY/$REPOSITORY:$TAG"
}

@test "the ruby version is correct" {
  run docker run --rm --entrypoint=/bin/sh $IMG -c "ruby -v | grep $RUBY_VERSION"
  [ $status -eq 0 ]
}

@test "the image can execute ruby code" {
  run docker run --rm --entrypoint=/bin/sh $IMG -c "ruby -e \"puts 'Hello'\" | grep Hello"
  [ $status -eq 0 ]
}

@test "the image has bundler installed" {
  run docker run --rm --entrypoint=/bin/sh $IMG -c "which bundler"
  [ $status -eq 0 ]
}

@test "the image is protected against CVE-2014-2525" {
  run docker run --rm --entrypoint=/bin/sh $IMG -c "ruby -rpsych -e 'p Psych.libyaml_version[2] > 5' | grep true"
  [ $status -eq 0 ]
}

@test "the image has a disk size under 130MB" {
  run docker images $IMG
  echo 'status:' $status
  echo 'output:' $output
  size="$(echo ${lines[1]} | awk -F '   *' '{ print int($5) }')"
  echo 'size:' $size
  [ "$status" -eq 0 ]
  [ $size -lt 130 ]
}

@test "the timezone is set to UTC" {
  run docker run --rm $IMG date +%Z
  [ $status -eq 0 ]
  [ "$output" = "UTC" ]
}

@test "that /var/cache/apk is empty" {
  run docker run --rm $IMG sh -c "ls -1 /var/cache/apk | wc -l"
  [ $status -eq 0 ]
}

@test "that the root password is disabled" {
  run docker run --user nobody $IMG su
  [ $status -eq 1 ]
}
