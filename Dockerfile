FROM nixos/nix:latest

WORKDIR /build
COPY . .

RUN echo "experimental-features = nix-command flakes" >> /etc/nix/nix.conf

RUN nix build .#astro-notebook

FROM scratch
COPY --from=0 /buildresult/astro-notebook.pdf /
