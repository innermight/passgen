	Add-Type -AssemblyName System.Windows.Forms
	Add-Type -AssemblyName System.Drawing

	[System.Windows.Forms.Application]::EnableVisualStyles()
	$form1 = New-Object 'System.Windows.Forms.Form'
	$button2 = New-Object 'System.Windows.Forms.Button'
	$checkbox4 = New-Object 'System.Windows.Forms.CheckBox'
	$numericupdown1 = New-Object 'System.Windows.Forms.NumericUpDown'
	$checkbox3 = New-Object 'System.Windows.Forms.CheckBox'
	$checkbox2 = New-Object 'System.Windows.Forms.CheckBox'
	$checkbox1 = New-Object 'System.Windows.Forms.CheckBox'
	$textbox1 = New-Object 'System.Windows.Forms.TextBox'
	$button1 = New-Object 'System.Windows.Forms.Button'
	$label1 = New-Object 'System.Windows.Forms.Label'
	$InitialFormWindowState = New-Object 'System.Windows.Forms.FormWindowState'
	
	$form1_Load = {
		$form1.Text = "Генератор паролей"
		$button1.Text = "Генерировать пароль"
		$button2.Text = "Очистить"
		$label1.Text = "Выбери длину пароля"
		$numericupdown1.Value = 6
		$checkbox1.Text = "Использовать маленькие буквы"
		$checkbox2.Text = "Использовать заглавные буквы"
		$checkbox3.Text = "Использовать цифры"
		$checkbox4.Text = "Использовать спец. символы"
		$global:azlow = New-Object 'System.Char[]' 26
		for ($i = 0; $i -lt 26; $i++){$azlow[$i] = [char]([int][char]'a' + $i)}
		
		$global:azhigh = New-Object 'System.Char[]' 26
		for ($i = 0; $i -lt 26; $i++){$azhigh[$i] = [char]([int][char]'A' + $i)}
		
		$global:numb = 0 .. 9
		$global:char = [char[]](32 .. 126 | Where-Object { $_ -ne 96 -and $_ -ne 32 -and ($_ -lt 48 -or ($_ -gt 57 -and $_ -lt 65) -or ($_ -gt 90 -and $_ -lt 97) -or $_ -gt 122) })
	}
	
	
	
	$button1_Click = {
		$password = @()
		$pi = 0
		$randarr = @()
		if ($numericupdown1.Value -lt 6) { $numericupdown1.value = 6 }
		if ($checkbox1.Checked)
		{
			$randarr += $azlow
			$password += $azlow | Get-Random
			$pi++
		}
		if ($checkbox2.Checked)
		{
			$randarr += $azhigh
			$password += $azhigh | Get-Random
			$pi++
		}
		if ($checkbox3.Checked)
		{
			$randarr += $numb
			$password += $numb | Get-Random
			$pi++
		}
		if ($checkbox4.Checked)
		{
			$randarr += $char
			$password += $char | Get-Random
			$pi++
		}
		if ($pi -eq 0)
		{
			[System.Windows.Forms.MessageBox]::Show("Для генерации пароля необходимо выбрать хотя бы одно условие")
			#$textbox1.Text = ""
		}
		else
		{
			for ($i = $pi; $i -lt $numericupdown1.Value; $i++)
			{
				$password += $randarr | Get-Random
			}
			$password = $password | Sort-Object -Property { Get-Random }
			$textbox1.Text += ($password -join "") + "`r`n"
		}
	}
	
	
	$button2_Click={
		$textbox1.Text = ""
	}
	
	$Form_StateCorrection_Load=
	{
		$form1.WindowState = $InitialFormWindowState
	}
	
	$Form_Cleanup_FormClosed=
	{
		try
		{
			$button2.remove_Click($button2_Click)
			$button1.remove_Click($button1_Click)
			$form1.remove_Load($form1_Load)
			$form1.remove_Load($Form_StateCorrection_Load)
			$form1.remove_FormClosed($Form_Cleanup_FormClosed)
		}
		catch { Out-Null }
	}
	
	$form1.SuspendLayout()
	$numericupdown1.BeginInit()
	
	$form1.Controls.Add($button2)
	$form1.Controls.Add($checkbox4)
	$form1.Controls.Add($numericupdown1)
	$form1.Controls.Add($checkbox3)
	$form1.Controls.Add($checkbox2)
	$form1.Controls.Add($checkbox1)
	$form1.Controls.Add($textbox1)
	$form1.Controls.Add($button1)
	$form1.Controls.Add($label1)
	$form1.AutoScaleDimensions = '6, 13'
	$form1.AutoScaleMode = 'Font'
	$form1.BackColor = 'ControlDarkDark'
	$form1.ClientSize = '305, 471'
	$form1.FormBorderStyle = 'FixedSingle'
	$form1.Name = 'form1'
	$form1.StartPosition = 'CenterScreen'
	$form1.Text = 'Form'
	$form1.add_Load($form1_Load)
	
	$button2.Location = '12, 436'
	$button2.Name = 'button2'
	$button2.Size = '281, 23'
	$button2.TabIndex = 9
	$button2.Text = 'button2'
	$button2.UseCompatibleTextRendering = $True
	$button2.UseVisualStyleBackColor = $True
	$button2.add_Click($button2_Click)
	
	$checkbox4.Location = '12, 117'
	$checkbox4.Name = 'checkbox4'
	$checkbox4.Size = '281, 24'
	$checkbox4.TabIndex = 8
	$checkbox4.Text = 'checkbox4'
	$checkbox4.UseCompatibleTextRendering = $True
	$checkbox4.UseVisualStyleBackColor = $True
	
	$numericupdown1.BackColor = 'AppWorkspace'
	$numericupdown1.Location = '135, 6'
	$numericupdown1.Maximum = 10000
	$numericupdown1.Name = 'numericupdown1'
	$numericupdown1.Size = '158, 20'
	$numericupdown1.TabIndex = 7
	
	$checkbox3.Location = '12, 96'
	$checkbox3.Name = 'checkbox3'
	$checkbox3.Size = '281, 24'
	$checkbox3.TabIndex = 6
	$checkbox3.Text = 'checkbox3'
	$checkbox3.UseCompatibleTextRendering = $True
	$checkbox3.UseVisualStyleBackColor = $True
	
	$checkbox2.Location = '12, 75'
	$checkbox2.Name = 'checkbox2'
	$checkbox2.Size = '281, 24'
	$checkbox2.TabIndex = 5
	$checkbox2.Text = 'checkbox2'
	$checkbox2.UseCompatibleTextRendering = $True
	$checkbox2.UseVisualStyleBackColor = $True
	
	$checkbox1.Location = '12, 55'
	$checkbox1.Name = 'checkbox1'
	$checkbox1.Size = '281, 24'
	$checkbox1.TabIndex = 4
	$checkbox1.Text = 'checkbox1'
	$checkbox1.UseCompatibleTextRendering = $True
	$checkbox1.UseVisualStyleBackColor = $True
	
	$textbox1.BackColor = 'AppWorkspace'
	$textbox1.Font = 'Consolas, 9pt, style=Bold'
	$textbox1.Location = '12, 176'
	$textbox1.Multiline = $True
	$textbox1.Name = 'textbox1'
	$textbox1.RightToLeft = 'No'
	$textbox1.ScrollBars = 'Vertical'
	$textbox1.Size = '281, 248'
	$textbox1.TabIndex = 3
	
	$button1.Location = '12, 147'
	$button1.Name = 'button1'
	$button1.Size = '281, 23'
	$button1.TabIndex = 2
	$button1.Text = 'button1'
	$button1.UseCompatibleTextRendering = $True
	$button1.UseVisualStyleBackColor = $True
	$button1.add_Click($button1_Click)
	
	$label1.AutoSize = $True
	$label1.Location = '12, 9'
	$label1.Name = 'label1'
	$label1.Size = '35, 17'
	$label1.TabIndex = 0
	$label1.Text = 'label1'
	$label1.UseCompatibleTextRendering = $True
	$numericupdown1.EndInit()
	$form1.ResumeLayout()
	
	$InitialFormWindowState = $form1.WindowState
	
	$form1.add_Load($Form_StateCorrection_Load)
	
	$form1.add_FormClosed($Form_Cleanup_FormClosed)
	
	return $form1.ShowDialog()