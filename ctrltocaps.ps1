$hexified = "00,00,00,00,00,00,00,00,03,00,00,00,3A,00,1D,00,1D,00,3A,00,00,00,00,00".Split(',') | % { "0x$_"};
$kbLayout = 'HKLM:\System\CurrentControlSet\Control\Keyboard Layout';
New-ItemProperty -Path $kbLayout -Name "Scancode Map" -PropertyType Binary -Value ([byte[]]$hexified);
pause
