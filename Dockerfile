FROM fluent/fluentd:v1.11

# Use root account to use apk
USER root

# below RUN includes plugin as examples elasticsearch is not required
# you may customize including plugins as you wish
RUN apk add --no-cache --update --virtual .build-deps \
        sudo build-base ruby-dev \
 && sudo gem install fluent-plugin-elasticsearch \
 && sudo gem install fluent-plugin-rewrite-tag-filter \
 && sudo gem install fluent-plugin-multi-format-parser \
 && sudo gem sources --clear-all \
 && apk del .build-deps \
 && apk add --no-cache tzdata \
 && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

env TZ=Asia/Kuala_Lumpur

USER fluent