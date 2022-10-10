[comment]: <> (See markdown `Ctrl + shift + V`)

# Swap keyboard Ctrl vs. CapsLock

1. Создать скрипт для записи в реестр правила `swap Ctrl - CapsLock` - сохранить в файл `ctrltocaps.ps1`:

    ```powershell
    $hexified = "00,00,00,00,00,00,00,00,03,00,00,00,3A,00,1D,00,1D,00,3A,00,00,00,00,00".Split(',') | % { "0x$_"};
    $kbLayout = 'HKLM:\System\CurrentControlSet\Control\Keyboard Layout';
    New-ItemProperty -Path $kbLayout -Name "Scancode Map" -PropertyType Binary -Value ([byte[]]$hexified);
    pause
    ```

2. Win + x

3. Windows Powershell (администратор)

4. `Powershell`: Перейти в папку, содержащую скрипт `ctrltocaps.ps1`

5. `Powershell`: Создать вр__е__менное правило для изменения политики приватности - правило применяется сразу (перезагрузка не нужна):

    ```powershell
    Set-ExecutionPolicy RemoteSigned
    ```

6. `Powershell`: Выполнить скрипт для создания правила изменения кнопок:

    ```powershell
    .\ctrltocaps.ps1
    ```

7. Reboot PC

8. Если понадобится вернуть кнопки в исходное состояние, то этот скрипт удалит правило из реестра - сохранить в файл `ctrltocaps-revert.bat`. Необходимо выполнить скрипт с правами администратора:

    ```batch
    REG DELETE "HKLM\SYSTEM\CurrentControlSet\Control\Keyboard Layout" /f /v "Scancode Map"
    pause
    ```

    После выполнения скрипта необходимо перезагрузить компьютер.
