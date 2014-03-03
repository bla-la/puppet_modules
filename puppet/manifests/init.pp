class puppet( $config = false)
{
    apt::install{"puppet-v3.4.2":}
}
