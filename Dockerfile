ARG     BASE_IMG=$BASE_IMG
FROM    $BASE_IMG AS base

RUN	apk --update --no-cache upgrade



FROM	base as ksrc

ARG     KERNEL_PKG=$KERNEL_PKG

RUN     apk --update --no-cache add \
        $KERNEL_PKG

RUN     for d in /lib/modules/*; do depmod -b . $(basename $d); done



FROM    ksrc AS build



FROM    scratch

COPY    --from=build /lib/modules /lib/modules
