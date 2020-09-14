FROM swift

RUN apt-get update && apt-get install -y \
    openssl \
    libssl-dev \
    libcurl4-openssl-dev \
    libpq-dev  \
    libgd-dev  \
    uuid-dev \
    tzdata -y \
 && rm -rf /var/lib/apt/lists/*

RUN ln -snf /usr/share/zoneinfo/Australia/Sydney /etc/localtime && dpkg-reconfigure -f noninteractive tzdata
 
RUN groupadd -g 1000 appuser && \
    useradd -r -u 1000 -g appuser appuser
WORKDIR /ZaraFull

COPY . .

RUN  chown appuser:appuser /ZaraFull -R
USER appuser 
RUN swift build -c release -Xswiftc -g 
# lldb --batch -o run -k "image list" -k "register read" -k "bt all" -k "exit 134"
CMD  .build/x86_64-unknown-linux/release/WebSocketsServer