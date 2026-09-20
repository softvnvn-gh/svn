# You need to have Administrator rights to run this script!
    if (-not([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        Write-Warning "You need to have Administrator rights to run this script!`nPlease re-run this script as an Administrator in an elevated powershell prompt!"
        Start-Process -Verb runas -FilePath powershell.exe -ArgumentList "-ExecutionPolicy Bypass -File `"$PSCommandPath`""
        break
    }

# Load ddls to the current session.
    Add-Type -AssemblyName PresentationFramework, System.Drawing, PresentationFramework, System.Windows.Forms, WindowsFormsIntegration, PresentationCore
    [System.Windows.Forms.Application]::EnableVisualStyles()

# Place your xaml code from Visual Studio in here string (between @ symbols)
# $xamlinput = @'<xaml code here'@

$xamlInput = @'
<Window x:Class="install.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Microsoft Installation Tool - softvn.vn" ResizeMode="NoResize" WindowStartupLocation="CenterScreen" Icon="https://msgang.com/wp-content/uploads/2025/07/images.png" Width="1240" SizeToContent="Height" Background="#FFF1F5F9"
        FontFamily="Segoe UI, Inter, Outfit, sans-serif">
    <Window.Resources>
        <!-- Dark Sidebar Radio Button Style -->
        <Style TargetType="RadioButton" x:Key="SidebarRadio">
            <Setter Property="Margin" Value="0,4,0,4"></Setter>
            <Setter Property="Foreground" Value="#FFA0AEC0"></Setter>
            <Setter Property="FontSize" Value="12"></Setter>
            <Setter Property="Cursor" Value="Hand"></Setter>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="RadioButton">
                        <BulletDecorator Background="Transparent" Cursor="Hand">
                            <BulletDecorator.Bullet>
                                <Grid Width="14" Height="14">
                                    <Ellipse Name="SidebarBorder" Stroke="#FF4A5568" StrokeThickness="1.5" Fill="#FF1E1B29"></Ellipse>
                                    <Ellipse Name="SidebarDot" Width="6" Height="6" Fill="#FF4F46E5" Visibility="Collapsed"></Ellipse>
                                </Grid>
                            </BulletDecorator.Bullet>
                            <ContentPresenter Margin="8,0,0,0" VerticalAlignment="Center" RecognizesAccessKey="True"></ContentPresenter>
                        </BulletDecorator>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsChecked" Value="True">
                                <Setter TargetName="SidebarBorder" Property="Stroke" Value="#FF4F46E5"></Setter>
                                <Setter TargetName="SidebarDot" Property="Visibility" Value="Visible"></Setter>
                                <Setter Property="Foreground" Value="#FFFFFFFF"></Setter>
                            </Trigger>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="SidebarBorder" Property="Stroke" Value="#FF718096"></Setter>
                                <Setter Property="Foreground" Value="#FFFFFFFF"></Setter>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <!-- Standard Card Radio Button Style -->
        <Style TargetType="RadioButton">
            <Setter Property="Margin" Value="0,3,0,3"></Setter>
            <Setter Property="Foreground" Value="#FF475569"></Setter>
            <Setter Property="FontSize" Value="11"></Setter>
            <Setter Property="Cursor" Value="Hand"></Setter>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="RadioButton">
                        <BulletDecorator Background="Transparent" Cursor="Hand">
                            <BulletDecorator.Bullet>
                                <Grid Width="14" Height="14">
                                    <Ellipse Name="CardBorder" Stroke="#FFCBD5E1" StrokeThickness="1.5" Fill="White"></Ellipse>
                                    <Ellipse Name="CardDot" Width="6" Height="6" Fill="#FF4F46E5" Visibility="Collapsed"></Ellipse>
                                </Grid>
                            </BulletDecorator.Bullet>
                            <ContentPresenter Margin="6,0,0,0" VerticalAlignment="Center" RecognizesAccessKey="True"></ContentPresenter>
                        </BulletDecorator>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsChecked" Value="True">
                                <Setter TargetName="CardBorder" Property="Stroke" Value="#FF4F46E5"></Setter>
                                <Setter TargetName="CardDot" Property="Visibility" Value="Visible"></Setter>
                                <Setter Property="Foreground" Value="#FF0F172A"></Setter>
                            </Trigger>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="CardBorder" Property="Stroke" Value="#FF94A3B8"></Setter>
                                <Setter Property="Foreground" Value="#FF0F172A"></Setter>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
    </Window.Resources>
    
    <Grid>
        <Grid.ColumnDefinitions>
            <ColumnDefinition Width="240"></ColumnDefinition>
            <ColumnDefinition Width="*"></ColumnDefinition>
        </Grid.ColumnDefinitions>
        
        <!-- Sidebar container -->
        <Border Grid.Column="0" Background="#FF13111C">
            <Grid Margin="20">
                <Grid.RowDefinitions>
                    <RowDefinition Height="Auto"></RowDefinition>
                    <RowDefinition Height="Auto"></RowDefinition>
                    <RowDefinition Height="Auto"></RowDefinition>
                    <RowDefinition Height="Auto"></RowDefinition>
                    <RowDefinition Height="*"></RowDefinition>
                </Grid.RowDefinitions>
                
                <!-- Logo brand section -->
                <StackPanel Grid.Row="0" Orientation="Horizontal" Margin="0,4,0,24">
                    <Border Width="6" Height="20" CornerRadius="3" Background="#FF4F46E5" Margin="0,0,10,0"></Border>
                    <TextBlock Text="SOFTVN" Foreground="White" FontSize="16" FontWeight="Black" VerticalAlignment="Center"></TextBlock>
                </StackPanel>
                
                <StackPanel Grid.Row="1" Margin="0,0,0,18">
                    <TextBlock Text="ARCHITECTURE" FontWeight="Bold" FontSize="9" Foreground="#FF5B5570" Margin="0,0,0,8"></TextBlock>
                    <RadioButton x:Name="radioButtonArch64" Content="64-bit (Recommended)" IsChecked="True" Style="{StaticResource SidebarRadio}"></RadioButton>
                    <RadioButton x:Name="radioButtonArch32" Content="32-bit" Style="{StaticResource SidebarRadio}"></RadioButton>
                </StackPanel>
                
                <StackPanel Grid.Row="2" Margin="0,0,0,18">
                    <TextBlock Text="LICENSE TYPE" FontWeight="Bold" FontSize="9" Foreground="#FF5B5570" Margin="0,0,0,8"></TextBlock>
                    <RadioButton x:Name="radioButtonVolume" Content="Volume" IsChecked="True" Style="{StaticResource SidebarRadio}"></RadioButton>
                    <RadioButton x:Name="radioButtonRetail" Content="Retail" Style="{StaticResource SidebarRadio}"></RadioButton>
                </StackPanel>
                
                <StackPanel Grid.Row="3" Margin="0,0,0,18">
                    <TextBlock Text="MODE" FontWeight="Bold" FontSize="9" Foreground="#FF5B5570" Margin="0,0,0,8"></TextBlock>
                    <RadioButton x:Name="radioButtonInstall" Content="Install now" IsChecked="True" Style="{StaticResource SidebarRadio}"></RadioButton>
                    <RadioButton x:Name="radioButtonDownload" Content="Download only" Style="{StaticResource SidebarRadio}"></RadioButton>
                </StackPanel>
                
                <StackPanel Grid.Row="4" Margin="0,0,0,0">
                    <TextBlock Text="LANGUAGE" FontWeight="Bold" FontSize="9" Foreground="#FF5B5570" Margin="0,0,0,8"></TextBlock>
                    <UniformGrid Columns="2" Rows="6">
                        <RadioButton x:Name="radioButtonEnglish" Content="English" IsChecked="True" Style="{StaticResource SidebarRadio}"></RadioButton>
                        <RadioButton x:Name="radioButtonVietnamese" Content="Vietnamese" Style="{StaticResource SidebarRadio}"></RadioButton>
                        <RadioButton x:Name="radioButtonJapanese" Content="Japanese" Style="{StaticResource SidebarRadio}"></RadioButton>
                        <RadioButton x:Name="radioButtonKorean" Content="Korean" Style="{StaticResource SidebarRadio}"></RadioButton>
                        <RadioButton x:Name="radioButtonChinese" Content="Chinese" Style="{StaticResource SidebarRadio}"></RadioButton>
                        <RadioButton x:Name="radioButtonFrench" Content="French" Style="{StaticResource SidebarRadio}"></RadioButton>
                        <RadioButton x:Name="radioButtonSpanish" Content="Spanish" Style="{StaticResource SidebarRadio}"></RadioButton>
                        <RadioButton x:Name="radioButtonHindi" Content="Hindi" Style="{StaticResource SidebarRadio}"></RadioButton>
                        <RadioButton x:Name="radioButtonGerman" Content="German" Style="{StaticResource SidebarRadio}"></RadioButton>
                        <RadioButton x:Name="radioButtonItalian" Content="Italian" Style="{StaticResource SidebarRadio}"></RadioButton>
                        <RadioButton x:Name="radioButtonPortuguese" Content="Portuguese" Style="{StaticResource SidebarRadio}"></RadioButton>
                        <RadioButton x:Name="radioButtonRussian" Content="Russian" Style="{StaticResource SidebarRadio}"></RadioButton>
                    </UniformGrid>
                </StackPanel>
            </Grid>
        </Border>
        
        <Grid Grid.Column="1" Margin="32,0,32,24">
            <Grid.RowDefinitions>
                <RowDefinition Height="Auto"></RowDefinition>
                <RowDefinition Height="*"></RowDefinition>
                <RowDefinition Height="Auto"></RowDefinition>
            </Grid.RowDefinitions>
            
            <Grid Grid.Row="0" Margin="0,0,0,12">
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="*"></ColumnDefinition>
                    <ColumnDefinition Width="Auto"></ColumnDefinition>
                </Grid.ColumnDefinitions>
                <StackPanel Grid.Column="0" VerticalAlignment="Center">
                    <TextBlock Text="Select Product" FontSize="20" FontWeight="Bold" Foreground="#FF0F172A"></TextBlock>
                    <TextBlock Text="Choose the Microsoft Office product you want to install or download." FontSize="11" Foreground="#FF64748B" Margin="0,2,0,0"></TextBlock>
                </StackPanel>
                <Button Grid.Column="1" x:Name="buttonClearSelection" Content="Clear Selection" Width="120" Height="32" Background="#FFFFFFFF" Foreground="#FF334155" FontWeight="SemiBold" FontSize="11" BorderBrush="#FFCBD5E1" BorderThickness="1" Cursor="Hand" HorizontalAlignment="Right" VerticalAlignment="Center">
                    <Button.Template>
                        <ControlTemplate TargetType="Button">
                            <Border Background="{TemplateBinding Background}" BorderBrush="{TemplateBinding BorderBrush}" BorderThickness="{TemplateBinding BorderThickness}" CornerRadius="6">
                                <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"></ContentPresenter>
                            </Border>
                        </ControlTemplate>
                    </Button.Template>
                </Button>
            </Grid>
            
            <!-- Products Grid without scrollbar -->
            <UniformGrid Grid.Row="1" Columns="6" Rows="1" Margin="-4">
                <Border Background="#FFFFFFFF" BorderBrush="#FFE2E8F0" BorderThickness="1" CornerRadius="8" Margin="4" Padding="8,12,4,12">
                    <StackPanel>
                        <TextBlock Text="Microsoft 365" FontSize="15" FontWeight="Bold" Foreground="#FF4F46E5" Margin="0,0,0,10"></TextBlock>
                        <RadioButton x:Name="radioButton365Home" GroupName="OfficeProducts" Content="Home"></RadioButton>
                        <RadioButton x:Name="radioButton365Business" GroupName="OfficeProducts" Content="Business"></RadioButton>
                        <RadioButton x:Name="radioButton365Enterprise" GroupName="OfficeProducts" Content="Enterprise"></RadioButton>
                    </StackPanel>
                </Border>
                
                <Border Background="#FFFFFFFF" BorderBrush="#FFE2E8F0" BorderThickness="1" CornerRadius="8" Margin="4" Padding="8,12,4,12">
                    <Grid>
                        <Grid.RowDefinitions>
                            <RowDefinition Height="Auto"></RowDefinition>
                            <RowDefinition Height="*"></RowDefinition>
                        </Grid.RowDefinitions>
                        <TextBlock Grid.Row="0" Text="Office 2024" FontSize="15" FontWeight="Bold" Foreground="#FFD97706" Margin="0,0,0,10"></TextBlock>
                        <StackPanel Grid.Row="1" Margin="0,0,0,0">
                            <RadioButton x:Name="radioButton2024Pro" GroupName="OfficeProducts" Content="Professional"></RadioButton>
                            <RadioButton x:Name="radioButton2024Std" GroupName="OfficeProducts" Content="Standard"></RadioButton>
                            <RadioButton x:Name="radioButton2024ProjectPro" GroupName="OfficeProducts" Content="Project Pro"></RadioButton>
                            <RadioButton x:Name="radioButton2024ProjectStd" GroupName="OfficeProducts" Content="Project Standard"></RadioButton>
                            <RadioButton x:Name="radioButton2024VisioPro" GroupName="OfficeProducts" Content="Visio Pro"></RadioButton>
                            <RadioButton x:Name="radioButton2024VisioStd" GroupName="OfficeProducts" Content="Visio Standard"></RadioButton>
                            <RadioButton x:Name="radioButton2024Word" GroupName="OfficeProducts" Content="Word"></RadioButton>
                            <RadioButton x:Name="radioButton2024Excel" GroupName="OfficeProducts" Content="Excel"></RadioButton>
                            <RadioButton x:Name="radioButton2024PowerPoint" GroupName="OfficeProducts" Content="PowerPoint"></RadioButton>
                            <RadioButton x:Name="radioButton2024Outlook" GroupName="OfficeProducts" Content="Outlook"></RadioButton>
                            <RadioButton x:Name="radioButton2024Access" GroupName="OfficeProducts" Content="Access"></RadioButton>
                            <RadioButton x:Name="radioButton2024Publisher" GroupName="OfficeProducts" Content="Publisher"></RadioButton>
                            <RadioButton x:Name="radioButton2024HomeStudent" GroupName="OfficeProducts" Content="Home Student"></RadioButton>
                            <RadioButton x:Name="radioButton2024HomeBusiness" GroupName="OfficeProducts" Content="Home Business"></RadioButton>
                        </StackPanel>
                    </Grid>
                </Border>
                
                <Border Background="#FFFFFFFF" BorderBrush="#FFE2E8F0" BorderThickness="1" CornerRadius="8" Margin="4" Padding="8,12,4,12">
                    <Grid>
                        <Grid.RowDefinitions>
                            <RowDefinition Height="Auto"></RowDefinition>
                            <RowDefinition Height="*"></RowDefinition>
                        </Grid.RowDefinitions>
                        <TextBlock Grid.Row="0" Text="Office 2021" FontSize="15" FontWeight="Bold" Foreground="#FF059669" Margin="0,0,0,10"></TextBlock>
                        <StackPanel Grid.Row="1" Margin="0,0,0,0">
                            <RadioButton x:Name="radioButton2021Pro" GroupName="OfficeProducts" Content="Professional"></RadioButton>
                            <RadioButton x:Name="radioButton2021Std" GroupName="OfficeProducts" Content="Standard"></RadioButton>
                            <RadioButton x:Name="radioButton2021ProjectPro" GroupName="OfficeProducts" Content="Project Pro"></RadioButton>
                            <RadioButton x:Name="radioButton2021ProjectStd" GroupName="OfficeProducts" Content="Project Standard"></RadioButton>
                            <RadioButton x:Name="radioButton2021VisioPro" GroupName="OfficeProducts" Content="Visio Pro"></RadioButton>
                            <RadioButton x:Name="radioButton2021VisioStd" GroupName="OfficeProducts" Content="Visio Standard"></RadioButton>
                            <RadioButton x:Name="radioButton2021Word" GroupName="OfficeProducts" Content="Word"></RadioButton>
                            <RadioButton x:Name="radioButton2021Excel" GroupName="OfficeProducts" Content="Excel"></RadioButton>
                            <RadioButton x:Name="radioButton2021PowerPoint" GroupName="OfficeProducts" Content="PowerPoint"></RadioButton>
                            <RadioButton x:Name="radioButton2021Outlook" GroupName="OfficeProducts" Content="Outlook"></RadioButton>
                            <RadioButton x:Name="radioButton2021Access" GroupName="OfficeProducts" Content="Access"></RadioButton>
                            <RadioButton x:Name="radioButton2021Publisher" GroupName="OfficeProducts" Content="Publisher"></RadioButton>
                            <RadioButton x:Name="radioButton2021HomeStudent" GroupName="OfficeProducts" Content="Home Student"></RadioButton>
                            <RadioButton x:Name="radioButton2021HomeBusiness" GroupName="OfficeProducts" Content="Home Business"></RadioButton>
                        </StackPanel>
                    </Grid>
                </Border>
                
                <Border Background="#FFFFFFFF" BorderBrush="#FFE2E8F0" BorderThickness="1" CornerRadius="8" Margin="4" Padding="8,12,4,12">
                    <Grid>
                        <Grid.RowDefinitions>
                            <RowDefinition Height="Auto"></RowDefinition>
                            <RowDefinition Height="*"></RowDefinition>
                        </Grid.RowDefinitions>
                        <TextBlock Grid.Row="0" Text="Office 2019" FontSize="15" FontWeight="Bold" Foreground="#FF2563EB" Margin="0,0,0,10"></TextBlock>
                        <StackPanel Grid.Row="1" Margin="0,0,0,0">
                            <RadioButton x:Name="radioButton2019Pro" GroupName="OfficeProducts" Content="Professional"></RadioButton>
                            <RadioButton x:Name="radioButton2019Std" GroupName="OfficeProducts" Content="Standard"></RadioButton>
                            <RadioButton x:Name="radioButton2019ProjectPro" GroupName="OfficeProducts" Content="Project Pro"></RadioButton>
                            <RadioButton x:Name="radioButton2019ProjectStd" GroupName="OfficeProducts" Content="Project Standard"></RadioButton>
                            <RadioButton x:Name="radioButton2019VisioPro" GroupName="OfficeProducts" Content="Visio Pro"></RadioButton>
                            <RadioButton x:Name="radioButton2019VisioStd" GroupName="OfficeProducts" Content="Visio Standard"></RadioButton>
                            <RadioButton x:Name="radioButton2019Word" GroupName="OfficeProducts" Content="Word"></RadioButton>
                            <RadioButton x:Name="radioButton2019Excel" GroupName="OfficeProducts" Content="Excel"></RadioButton>
                            <RadioButton x:Name="radioButton2019PowerPoint" GroupName="OfficeProducts" Content="PowerPoint"></RadioButton>
                            <RadioButton x:Name="radioButton2019Outlook" GroupName="OfficeProducts" Content="Outlook"></RadioButton>
                            <RadioButton x:Name="radioButton2019Access" GroupName="OfficeProducts" Content="Access"></RadioButton>
                            <RadioButton x:Name="radioButton2019Publisher" GroupName="OfficeProducts" Content="Publisher"></RadioButton>
                            <RadioButton x:Name="radioButton2019HomeStudent" GroupName="OfficeProducts" Content="Home Student"></RadioButton>
                            <RadioButton x:Name="radioButton2019HomeBusiness" GroupName="OfficeProducts" Content="Home Business"></RadioButton>
                        </StackPanel>
                    </Grid>
                </Border>
                
                <Border Background="#FFFFFFFF" BorderBrush="#FFE2E8F0" BorderThickness="1" CornerRadius="8" Margin="4" Padding="8,12,4,12">
                    <Grid>
                        <Grid.RowDefinitions>
                            <RowDefinition Height="Auto"></RowDefinition>
                            <RowDefinition Height="*"></RowDefinition>
                        </Grid.RowDefinitions>
                        <TextBlock Grid.Row="0" Text="Office 2016" FontSize="15" FontWeight="Bold" Foreground="#FF9333EA" Margin="0,0,0,10"></TextBlock>
                        <StackPanel Grid.Row="1" Margin="0,0,0,0">
                            <RadioButton x:Name="radioButton2016Pro" GroupName="OfficeProducts" Content="Professional"></RadioButton>
                            <RadioButton x:Name="radioButton2016Std" GroupName="OfficeProducts" Content="Standard"></RadioButton>
                            <RadioButton x:Name="radioButton2016ProjectPro" GroupName="OfficeProducts" Content="Project Pro"></RadioButton>
                            <RadioButton x:Name="radioButton2016ProjectStd" GroupName="OfficeProducts" Content="Project Standard"></RadioButton>
                            <RadioButton x:Name="radioButton2016VisioPro" GroupName="OfficeProducts" Content="Visio Pro"></RadioButton>
                            <RadioButton x:Name="radioButton2016VisioStd" GroupName="OfficeProducts" Content="Visio Standard"></RadioButton>
                            <RadioButton x:Name="radioButton2016Word" GroupName="OfficeProducts" Content="Word"></RadioButton>
                            <RadioButton x:Name="radioButton2016Excel" GroupName="OfficeProducts" Content="Excel"></RadioButton>
                            <RadioButton x:Name="radioButton2016PowerPoint" GroupName="OfficeProducts" Content="PowerPoint"></RadioButton>
                            <RadioButton x:Name="radioButton2016Outlook" GroupName="OfficeProducts" Content="Outlook"></RadioButton>
                            <RadioButton x:Name="radioButton2016Access" GroupName="OfficeProducts" Content="Access"></RadioButton>
                            <RadioButton x:Name="radioButton2016Publisher" GroupName="OfficeProducts" Content="Publisher"></RadioButton>
                            <RadioButton x:Name="radioButton2016OneNote" GroupName="OfficeProducts" Content="OneNote"></RadioButton>
                        </StackPanel>
                    </Grid>
                </Border>
                
                <Border Background="#FFFFFFFF" BorderBrush="#FFE2E8F0" BorderThickness="1" CornerRadius="8" Margin="4" Padding="8,12,4,12">
                    <Grid>
                        <Grid.RowDefinitions>
                            <RowDefinition Height="Auto"></RowDefinition>
                            <RowDefinition Height="*"></RowDefinition>
                        </Grid.RowDefinitions>
                        <TextBlock Grid.Row="0" Text="Office 2013" FontSize="15" FontWeight="Bold" Foreground="#FFBE123C" Margin="0,0,0,10"></TextBlock>
                        <StackPanel Grid.Row="1" Margin="0,0,0,0">
                            <RadioButton x:Name="radioButton2013Pro" GroupName="OfficeProducts" Content="Professional"></RadioButton>
                            <RadioButton x:Name="radioButton2013Std" GroupName="OfficeProducts" Content="Standard"></RadioButton>
                            <RadioButton x:Name="radioButton2013ProjectPro" GroupName="OfficeProducts" Content="Project Pro"></RadioButton>
                            <RadioButton x:Name="radioButton2013ProjectStd" GroupName="OfficeProducts" Content="Project Standard"></RadioButton>
                            <RadioButton x:Name="radioButton2013VisioPro" GroupName="OfficeProducts" Content="Visio Pro"></RadioButton>
                            <RadioButton x:Name="radioButton2013VisioStd" GroupName="OfficeProducts" Content="Visio Standard"></RadioButton>
                            <RadioButton x:Name="radioButton2013Word" GroupName="OfficeProducts" Content="Word"></RadioButton>
                            <RadioButton x:Name="radioButton2013Excel" GroupName="OfficeProducts" Content="Excel"></RadioButton>
                            <RadioButton x:Name="radioButton2013PowerPoint" GroupName="OfficeProducts" Content="PowerPoint"></RadioButton>
                            <RadioButton x:Name="radioButton2013Outlook" GroupName="OfficeProducts" Content="Outlook"></RadioButton>
                            <RadioButton x:Name="radioButton2013Access" GroupName="OfficeProducts" Content="Access"></RadioButton>
                            <RadioButton x:Name="radioButton2013Publisher" GroupName="OfficeProducts" Content="Publisher"></RadioButton>
                        </StackPanel>
                    </Grid>
                </Border>
            </UniformGrid>
            
            <Grid Grid.Row="2" Margin="0,20,0,0">
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="Auto"></ColumnDefinition>
                    <ColumnDefinition Width="*"></ColumnDefinition>
                    <ColumnDefinition Width="Auto"></ColumnDefinition>
                </Grid.ColumnDefinitions>
                
                <Border Grid.Column="2" HorizontalAlignment="Right" Background="#FFFFF1F2" BorderBrush="#FFE11D48" BorderThickness="1" CornerRadius="10" Padding="16,12">
                    <StackPanel Orientation="Horizontal" VerticalAlignment="Center">
                        <StackPanel VerticalAlignment="Center" Margin="0,0,18,0">
                            <TextBlock Text="Remove All Apps" FontWeight="Bold" Foreground="#FFE11D48" FontSize="13"></TextBlock>
                            <TextBlock Text="Caution: Uninstall all Office apps" Foreground="#FFBE123C" FontSize="10" Margin="0,2,0,0"></TextBlock>
                        </StackPanel>
                        <StackPanel Orientation="Horizontal" VerticalAlignment="Center">
                            <RadioButton x:Name="radioButtonRemoveAllApp" Content="I Agree" Foreground="#FFE11D48" FontWeight="SemiBold" VerticalAlignment="Center" Margin="0,0,12,0"></RadioButton>
                            <Button x:Name="buttonRemoveAll" Content="Uninstall" Width="80" Height="32" Background="#FFE11D48" Foreground="White" FontWeight="SemiBold" BorderThickness="0" Cursor="Hand">
                                <Button.Template>
                                    <ControlTemplate TargetType="Button">
                                        <Border Background="{TemplateBinding Background}" CornerRadius="6">
                                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"></ContentPresenter>
                                        </Border>
                                    </ControlTemplate>
                                </Button.Template>
                            </Button>
                        </StackPanel>
                    </StackPanel>
                </Border>
                
                <StackPanel Grid.Column="0" HorizontalAlignment="Left" VerticalAlignment="Center" Width="280">
                    <Button x:Name="buttonSubmitMain" Content="Submit Action" Height="44" Background="#FF4F46E5" Foreground="White" FontWeight="Bold" FontSize="14" BorderThickness="0" Cursor="Hand">
                        <Button.Template>
                            <ControlTemplate TargetType="Button">
                                <Border Background="{TemplateBinding Background}" CornerRadius="8">
                                    <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"></ContentPresenter>
                                </Border>
                            </ControlTemplate>
                        </Button.Template>
                    </Button>
                    <ProgressBar x:Name="progressbarMain" Margin="0,0,0,0" Height="6" IsEnabled="False" Background="#FFE2E8F0" BorderThickness="0" Foreground="#FF4F46E5" Visibility="Collapsed"></ProgressBar>
                    <TextBox x:Name="textboxMain" Margin="0,6,0,0" TextWrapping="Wrap" MinHeight="20" FontSize="11" Foreground="#FF475569" HorizontalContentAlignment="Center" Background="Transparent" BorderThickness="0" Focusable="False" IsHitTestVisible="False" Visibility="Collapsed"></TextBox>
                </StackPanel>
            </Grid>
        </Grid>
    </Grid>
</Window>
'@

# Store form objects (variables) in PowerShell

    [xml]$xaml = $xamlInput -replace '^<Window.*', '<Window' -replace 'mc:Ignorable="d"','' -replace "x:Name",'Name'
    $xmlReader = (New-Object System.Xml.XmlNodeReader $xaml)
    $Form = [Windows.Markup.XamlReader]::Load( $xmlReader)

    $xaml.SelectNodes("//*[@Name]") | ForEach-Object -Process {
        Set-Variable -Name ($_.Name) -Value $Form.FindName($_.Name)
    }

    $buttonSubmit = $buttonSubmitMain
    $progressbar = $progressbarMain
    $textbox = $textboxMain
    $sync = [hashtable]::Synchronized(@{
        isBusy = $false
        lastPowerShell = $null
    })

    $officeProductButtons = @(
        $radioButton365Home, $radioButton365Business, $radioButton365Enterprise,
        $radioButton2024Pro, $radioButton2024Std, $radioButton2024ProjectPro, $radioButton2024ProjectStd,
        $radioButton2024VisioPro, $radioButton2024VisioStd, $radioButton2024Word, $radioButton2024Excel,
        $radioButton2024PowerPoint, $radioButton2024Outlook, $radioButton2024Access, $radioButton2024Publisher,
        $radioButton2024HomeStudent, $radioButton2024HomeBusiness,
        $radioButton2021Pro, $radioButton2021Std, $radioButton2021ProjectPro, $radioButton2021ProjectStd,
        $radioButton2021VisioPro, $radioButton2021VisioStd, $radioButton2021Word, $radioButton2021Excel,
        $radioButton2021PowerPoint, $radioButton2021Outlook, $radioButton2021Access, $radioButton2021Publisher,
        $radioButton2021HomeStudent, $radioButton2021HomeBusiness,
        $radioButton2019Pro, $radioButton2019Std, $radioButton2019ProjectPro, $radioButton2019ProjectStd,
        $radioButton2019VisioPro, $radioButton2019VisioStd, $radioButton2019Word, $radioButton2019Excel,
        $radioButton2019PowerPoint, $radioButton2019Outlook, $radioButton2019Access, $radioButton2019Publisher,
        $radioButton2019HomeStudent, $radioButton2019HomeBusiness,
        $radioButton2016Pro, $radioButton2016Std, $radioButton2016ProjectPro, $radioButton2016ProjectStd,
        $radioButton2016VisioPro, $radioButton2016VisioStd, $radioButton2016Word, $radioButton2016Excel,
        $radioButton2016PowerPoint, $radioButton2016Outlook, $radioButton2016Access, $radioButton2016Publisher,
        $radioButton2016OneNote,
        $radioButton2013Pro, $radioButton2013Std, $radioButton2013ProjectPro, $radioButton2013ProjectStd,
        $radioButton2013VisioPro, $radioButton2013VisioStd, $radioButton2013Word, $radioButton2013Excel,
        $radioButton2013PowerPoint, $radioButton2013Outlook, $radioButton2013Access, $radioButton2013Publisher
    )

    function UpdateSelectionMode {
        $hasProductSelection = $officeProductButtons | Where-Object { $_.IsChecked -eq $true } | Select-Object -First 1
        $removeAllEnabled = -not [bool]$hasProductSelection
        $isBusy = [bool]$sync.isBusy

        $buttonSubmit.IsHitTestVisible = -not $isBusy
        $buttonSubmit.Opacity = if ($isBusy) { 0.75 } else { 1 }
        $buttonClearSelection.IsHitTestVisible = -not $isBusy
        $buttonClearSelection.Opacity = if ($isBusy) { 0.65 } else { 1 }

        $radioButtonRemoveAllApp.IsEnabled = $removeAllEnabled -and -not $isBusy
        $buttonRemoveAll.IsHitTestVisible = $removeAllEnabled -and ($radioButtonRemoveAllApp.IsChecked -eq $true) -and -not $isBusy
        $buttonRemoveAll.Cursor = if ($buttonRemoveAll.IsHitTestVisible) { 'Hand' } else { 'Arrow' }

        if (-not $removeAllEnabled) {
            $radioButtonRemoveAllApp.IsChecked = $false
        }

        $removeAllActive = $radioButtonRemoveAllApp.IsChecked -eq $true
        foreach ($button in $officeProductButtons) {
            $button.IsEnabled = (-not $removeAllActive) -and (-not $isBusy)
        }

        if ($hasProductSelection -or $removeAllActive) {
            $textbox.Text = ""
            $textbox.Visibility = "Collapsed"
        }
    }

    foreach ($button in $officeProductButtons) {
        $button.Add_Checked({ UpdateSelectionMode })
    }

    $radioButtonRemoveAllApp.Add_Checked({
        foreach ($button in $officeProductButtons) {
            $button.IsChecked = $false
        }
        UpdateSelectionMode
    })
    $radioButtonRemoveAllApp.Add_Unchecked({ UpdateSelectionMode })
    UpdateSelectionMode

    $buttonClearSelection.Add_Click({
        foreach ($button in $officeProductButtons) {
            $button.IsChecked = $false
        }
        $radioButtonRemoveAllApp.IsChecked = $false
        UpdateSelectionMode
    })

    function Start-BackgroundOperation {
        param(
            [Parameter(Mandatory)]
            [scriptblock]$Operation
        )

        if ($sync.isBusy) {
            return
        }

        if ($sync.lastPowerShell) {
            try { $sync.lastPowerShell.Dispose() } catch {}
            $sync.lastPowerShell = $null
        }

        $sync.isBusy = $true
        UpdateSelectionMode

        $powerShellInstance = [powershell]::Create().AddScript($Operation)
        $powerShellInstance.Runspace = $runspace
        $sync.lastPowerShell = $powerShellInstance
        $null = $powerShellInstance.BeginInvoke()
    }

    $sync.RestoreUiAction = [action]{
        $hasProductSelection = $sync.officeProductButtons | Where-Object { $_.IsChecked -eq $true } | Select-Object -First 1
        $removeAllEnabled = -not [bool]$hasProductSelection
        $sync.buttonSubmit.IsHitTestVisible = $true
        $sync.buttonSubmit.Opacity = 1
        $sync.buttonClearSelection.IsHitTestVisible = $true
        $sync.buttonClearSelection.Opacity = 1
        $sync.radioButtonRemoveAllApp.IsEnabled = $removeAllEnabled
        $sync.buttonRemoveAll.IsHitTestVisible = $removeAllEnabled -and ($sync.radioButtonRemoveAllApp.IsChecked -eq $true)
        $sync.buttonRemoveAll.Cursor = if ($sync.buttonRemoveAll.IsHitTestVisible) { 'Hand' } else { 'Arrow' }
        $removeAllActive = $sync.radioButtonRemoveAllApp.IsChecked -eq $true
        foreach ($button in $sync.officeProductButtons) {
            $button.IsEnabled = -not $removeAllActive
        }
    }

    $sync.ShowErrorAction = [action]{
        $sync.progressbar.Visibility = "Collapsed"
        $sync.textbox.Visibility = "Visible"
        $sync.textbox.Foreground = "#FFC62828"
        $sync.textbox.FontWeight = "Bold"
        $sync.textbox.Text = $sync.errorMessage
        $sync.buttonSubmit.Visibility = "Visible"
        $sync.buttonSubmit.Content = "Submit"
        & $sync.RestoreUiAction
    }

# Download links
    $uri            = "https://github.com/msgang822/microsoft/raw/refs/heads/main/files/office/setup.exe"
    $uri2013        = "https://github.com/msgang822/microsoft/raw/refs/heads/main/files/office/bin2013.exe"
    $uri2016        = "https://github.com/msgang822/microsoft/raw/refs/heads/main/files/office/setup.exe"
    $uninstall      = "https://github.com/msgang822/microsoft/raw/refs/heads/main/files/office/setup.exe"
    $removeAllXML   = 'https://raw.githubusercontent.com/msgang822/microsoft/refs/heads/main/files/office/RemoveAll/configuration.xml'

# Prepiaration for download and install
    function PreparingOffice {
        if ($radioButtonDownload.IsChecked) {
            $workingDir = New-Item -Path $env:userprofile\Desktop\$productId -ItemType Directory -Force
            Set-Location $workingDir
            Invoke-Item $workingDir
        }

        if ($radioButtonInstall.IsChecked) {
            $workingDir = New-Item -Path $env:temp\ClickToRun\$productId -ItemType Directory -Force
            Set-Location $workingDir
        }

        New-Item $workingDir\Configuration -ItemType Directory -Force
        $configurationFile = "configuration-x$arch.xml"
        New-Item .\Configuration\$configurationFile -ItemType File -Force
        Add-Content .\Configuration\$configurationFile -Value "<Configuration>"
        Add-content .\Configuration\$configurationFile -Value "<Add OfficeClientEdition=`"$arch`">"
        Add-content .\Configuration\$configurationFile -Value "<Product ID=`"$productId`">"
        Add-content .\Configuration\$configurationFile -Value "<Language ID=`"$languageId`"/>"
        Add-Content .\Configuration\$configurationFile -Value "</Product>"
        Add-Content .\Configuration\$configurationFile -Value "</Add>"
        Add-Content .\Configuration\$configurationFile -Value "</Configuration>"

        $batchFile = "Install-$($arch)bit.bat"
        New-Item $batchFile -ItemType File -Force
        Add-content $batchFile -Value "%~dp0Configuration\ClickToRun.exe /configure %~dp0Configuration\$configurationFile"

        # Dynamically fetch the official Microsoft Office Deployment Tool (ODT) download page
        try {
            $odtPage = Invoke-WebRequest -Uri "https://www.microsoft.com/en-us/download/details.aspx?id=49117" -UseBasicParsing -TimeoutSec 15
            if ($odtPage.Content -match 'https://download\.microsoft\.com/download/[^\s"<>]+/officedeploymenttool[^\s"<>]*\.exe') {
                $odtUrl = $Matches[0]
            } else {
                $odtUrl = "https://download.microsoft.com/download/6/c/1/6c1eeb25-cf8b-41d9-8d0d-cc1dbc032140/officedeploymenttool_20228-20124.exe" # Fallback link
            }
        } catch {
            $odtUrl = "https://download.microsoft.com/download/6/c/1/6c1eeb25-cf8b-41d9-8d0d-cc1dbc032140/officedeploymenttool_20228-20124.exe" # Fallback link
        }

        # Download self-extracting ODT installer
        $odtFile = "$workingDir\Configuration\odt.exe"
        (New-Object Net.WebClient).DownloadFile($odtUrl, $odtFile)

        # Extract setup.exe (ClickToRun.exe) quietly from the ODT installer
        Start-Process -FilePath $odtFile -ArgumentList "/quiet /extract:`"$workingDir\Configuration`"" -Wait -NoNewWindow
        
        # Rename setup.exe to ClickToRun.exe as expected by the script
        if (Test-Path "$workingDir\Configuration\setup.exe") {
            Rename-Item -Path "$workingDir\Configuration\setup.exe" -NewName "ClickToRun.exe" -Force
        }
        if (Test-Path $odtFile) {
            Remove-Item $odtFile -Force
        }

        $sync.configurationFile = $configurationFile
        $sync.workingDir = $workingDir
    }
    
# Creating script block for download and install
    $DownloadInstallOffice = {
        trap {
            $sync.isBusy = $false
            $sync.errorMessage = $_.Exception.Message
            $sync.Form.Dispatcher.Invoke($sync.ShowErrorAction)
            continue
        }
<#         function Write-HostDebug {
            #Helper function to write back to the host debug output
            param([Parameter(Mandatory)]
            [string]
            $debugMessage)
            if ($sync.DebugPreference) {
                $sync.host.UI.WriteDebugLine($debugMessage)
            }
        } #>

<#         function Write-VerboseDebug {
            param([Parameter(Mandatory)]
            [string]
            $verboseMessage)
            if ($sync.VerbosePreference) {
                $sync.host.UI.WriteVerboseLine($verboseMessage)
            }
        } #>

        # Write-VerboseDebug "Downloading the $($sync.productName)"
        # Write-VerboseDebug "Mode: $($sync.mode)"
        # Write-VerboseDebug "Configuration file: $($sync.configurationFile)"

        # To referece our elements we use the $sync variable from hashtable.
            $sync.Form.Dispatcher.Invoke([action] { $sync.buttonSubmit.Visibility = "Collapsed" })
            $sync.Form.Dispatcher.Invoke([action] { $sync.progressbar.Visibility = "Visible" })
            $sync.Form.Dispatcher.Invoke([action] { $sync.textbox.Visibility = "Visible" })
            $sync.Form.Dispatcher.Invoke([action] { $sync.textbox.Text = "$($sync.UIstatus) $($sync.productName) $($sync.arch)-bit ($($sync.language))" })
            $sync.Form.Dispatcher.Invoke([action] { $sync.ProgressBar.BorderBrush = "#FF707070" })
            $sync.Form.Dispatcher.Invoke([action] { $sync.ProgressBar.IsIndeterminate = $true })
        Set-Location -Path $($sync.workingDir)
        # Write-VerboseDebug "Working (download) path: $pwd"
        # Write-VerboseDebug "Command to run: .\Configuration\ClickToRun.exe $($sync.mode) .\Configuration\$($sync.configurationFile)"

        Start-Process -FilePath .\Configuration\ClickToRun.exe -ArgumentList "$($sync.mode) .\Configuration\$($sync.configurationFile)" -NoNewWindow -Wait
                
        # Bring back our Button, set the Label and ProgressBar, we're done..
            $sync.Form.Dispatcher.Invoke([action] { $sync.buttonSubmit.Visibility = 'Visible' })
            $sync.Form.Dispatcher.Invoke([action] { $sync.buttonSubmit.Content = 'Submit' })
            $sync.Form.Dispatcher.Invoke([action] { $sync.textbox.Visibility = 'Collapsed' })
            $sync.Form.Dispatcher.Invoke([action] { $sync.ProgressBar.Visibility = 'Collapsed' })
            $sync.Form.Dispatcher.Invoke([action] { $sync.ProgressBar.Value = '0' })
            $sync.isBusy = $false
            $sync.Form.Dispatcher.Invoke($sync.RestoreUiAction)

            # Write-VerboseDebug "Done. You can close this window now."
    }

# Share info between runspaces
    $sync.host = $host
    $sync.Form = $Form
    $sync.ProgressBar = $ProgressBar
    $sync.textbox = $textbox
    $sync.buttonSubmit = $buttonSubmit
    $sync.buttonClearSelection = $buttonClearSelection
    $sync.radioButtonRemoveAllApp = $radioButtonRemoveAllApp
    $sync.buttonRemoveAll = $buttonRemoveAll
    $sync.officeProductButtons = $officeProductButtons
    $sync.DebugPreference = $DebugPreference
    $sync.VerbosePreference = $VerbosePreference

# Build a runspace
    $runspace = [runspacefactory]::CreateRunspace()
    $runspace.ApartmentState = 'STA'
    $runspace.ThreadOptions = 'ReuseThread'
    $runspace.Open()

# Add shared data to the runspace
    $sync.runspace = $runspace
    $runspace.SessionStateProxy.SetVariable("sync", $sync)


    $buttonSubmit.Add_Click( {
        if ($sync.isBusy) {
            return
        }

        $i = 0
            if ($radioButtonArch32.IsChecked) {$arch = '32'}
            if ($radioButtonArch64.IsChecked) {$arch = '64'}

            if ($radioButtonVolume.IsChecked) {$licType = 'Volume'}
            if ($radioButtonRetail.IsChecked) {$licType = 'Retail'}

            if ($radioButtonEnglish.IsChecked) {$languageId="en-US"; $language = 'English'}
            if ($radioButtonJapanese.IsChecked) {$languageId="ja-JP"; $language = 'Japanese'}
            if ($radioButtonKorean.IsChecked) {$languageId="ko-KR"; $language = 'Korean'}
            if ($radioButtonChinese.IsChecked) {$languageId="zh-TW"; $language = 'Chinese'}
            if ($radioButtonFrench.IsChecked) {$languageId="fr-FR"; $language = 'French'}
            if ($radioButtonSpanish.IsChecked) {$languageId="es-ES"; $language = 'Spanish'}
            if ($radioButtonHindi.IsChecked) {$languageId="hi-IN"; $language = 'Hindi'}
            if ($radioButtonGerman.IsChecked) {$languageId="de-DE"; $language = 'German'}
            if ($radioButtonItalian.IsChecked) {$languageId="it-IT"; $language = 'Italian'}
            if ($radioButtonPortuguese.IsChecked) {$languageId="pt-BR"; $language = 'Portuguese'}
            if ($radioButtonRussian.IsChecked) {$languageId="ru-RU"; $language = 'Russian'}
            if ($radioButtonVietnamese.IsChecked) {$languageId="vi-VN"; $language = 'Vietnamese'}

            if ($radioButtonDownload.IsChecked) {$mode = '/download'; $UIstatus = 'Downlading'}
            if ($radioButtonInstall.IsChecked) {$mode = '/configure'; $UIstatus = 'Installing'}

            if ($radioButton365Home.IsChecked -eq $true) {$productId = "O365HomePremRetail"; $productName = 'Microsoft 365 Home'; $i++}
            if ($radioButton365Business.IsChecked -eq $true) {$productId = "O365BusinessRetail"; $productName = 'Microsoft 365 Apps for Business'; $i++}
            if ($radioButton365Enterprise.IsChecked -eq $true) {$productId = "O365ProPlusRetail"; $productName = 'Microsoft 365 Apps for Enterprise'; $i++}

        # For Office 2024
            if ($radioButton2024Pro.IsChecked -eq $true) {$productId = "ProPlus2024$licType"; $productName = 'Office 2024 Professional LTSC 2024'; $i++}
            if ($radioButton2024Std.IsChecked -eq $true) {$productId = "Standard2024$licType"; $productName = 'Office 2024 Standard LTSC'; $i++}
            if ($radioButton2024ProjectPro.IsChecked -eq $true) {$productId = "ProjectPro2024$licType"; $productName = 'Project Pro 2024'; $i++}
            if ($radioButton2024ProjectStd.IsChecked -eq $true) {$productId = "ProjectStd2024$licType"; $productName = 'Project Standard 2024'; $i++}
            if ($radioButton2024VisioPro.IsChecked -eq $true) {$productId = "VisioPro2024$licType"; $productName = 'Visio Pro 2024'; $i++}
            if ($radioButton2024VisioStd.IsChecked -eq $true) {$productId = "VisioStd2024$licType"; $productName = 'Visio Standard 2024'; $i++}
            if ($radioButton2024Word.IsChecked -eq $true) {$productId = "Word2024$licType"; $productName = 'Microsoft Word LTSC 2024'; $i++}
            if ($radioButton2024Excel.IsChecked -eq $true) {$productId = "Excel2024$licType"; $productName = 'Microsoft Excel LTSC 2024'; $i++}
            if ($radioButton2024PowerPoint.IsChecked -eq $true) {$productId = "PowerPoint2024$licType"; $productName = 'Microsoft PowerPoint LTSC 2024'; $i++}
            if ($radioButton2024Outlook.IsChecked -eq $true) {$productId = "Outlook2024$licType"; $productName = 'Microsoft Outlook LTSC 2024'; $i++}
            if ($radioButton2024Publisher.IsChecked -eq $true) {$productId = "Publisher2024$licType"; $productName = 'Microsoft Publisher LTSC 2024'; $i++}
            if ($radioButton2024Access.IsChecked -eq $true) {$productId = "Access2024$licType"; $productName = 'Microsoft Access LTSC 2024'; $i++}
            if ($radioButton2024HomeBusiness.IsChecked -eq $true) {$productId = "HomeBusiness2024Retail"; $productName = 'Office HomeBusiness 2024'; $i++}
            if ($radioButton2024HomeStudent.IsChecked -eq $true) {$productId = "HomeStudent2024Retail"; $productName = 'Office HomeStudent LTSC 2024'; $i++}

        # For Office 2021
            if ($radioButton2021Pro.IsChecked -eq $true) {$productId = "ProPlus2021$licType"; $productName = 'Office 2021 Professional LTSC 2021'; $i++}
            if ($radioButton2021Std.IsChecked -eq $true) {$productId = "Standard2021$licType"; $productName = 'Office 2021 Standard LTSC'; $i++}
            if ($radioButton2021ProjectPro.IsChecked -eq $true) {$productId = "ProjectPro2021$licType"; $productName = 'Project Pro 2021'; $i++}
            if ($radioButton2021ProjectStd.IsChecked -eq $true) {$productId = "ProjectStd2021$licType"; $productName = 'Project Standard 2021'; $i++}
            if ($radioButton2021VisioPro.IsChecked -eq $true) {$productId = "VisioPro2021$licType"; $productName = 'Visio Pro 2021'; $i++}
            if ($radioButton2021VisioStd.IsChecked -eq $true) {$productId = "VisioStd2021$licType"; $productName = 'Visio Standard 2021'; $i++}
            if ($radioButton2021Word.IsChecked -eq $true) {$productId = "Word2021$licType"; $productName = 'Microsoft Word LTSC 2021'; $i++}
            if ($radioButton2021Excel.IsChecked -eq $true) {$productId = "Excel2021$licType"; $productName = 'Microsoft Excel LTSC 2021'; $i++}
            if ($radioButton2021PowerPoint.IsChecked -eq $true) {$productId = "PowerPoint2021$licType"; $productName = 'Microsoft PowerPoint LTSC 2021'; $i++}
            if ($radioButton2021Outlook.IsChecked -eq $true) {$productId = "Outlook2021$licType"; $productName = 'Microsoft Outlook LTSC 2021'; $i++}
            if ($radioButton2021Publisher.IsChecked -eq $true) {$productId = "Publisher2021$licType"; $productName = 'Microsoft Publisher LTSC 2021'; $i++}
            if ($radioButton2021Access.IsChecked -eq $true) {$productId = "Access2021$licType"; $productName = 'Microsoft Access LTSC 2021'; $i++}
            if ($radioButton2021HomeBusiness.IsChecked -eq $true) {$productId = "HomeBusiness2021Retail"; $productName = 'Office HomeBusiness 2021'; $i++}
            if ($radioButton2021HomeStudent.IsChecked -eq $true) {$productId = "HomeStudent2021Retail"; $productName = 'Office HomeStudent LTSC 2021'; $i++}

        # For Office 2019
            if ($radioButton2019Pro.IsChecked -eq $true) {$productId = "ProPlus2019$licType"; $productName = 'Office 2019 Professional Plus'; $i++}
            if ($radioButton2019Std.IsChecked -eq $true) {$productId = "Standard2019$licType"; $productName = 'Office 2019 Standard'; $i++}
            if ($radioButton2019ProjectPro.IsChecked -eq $true) {$productId = "ProjectPro2019$licType"; $productName = 'Project Pro 2019'; $i++}
            if ($radioButton2019ProjectStd.IsChecked -eq $true) {$productId = "ProjectStd2019$licType"; $productName = 'Project Standard 2019'; $i++}
            if ($radioButton2019VisioPro.IsChecked -eq $true) {$productId = "VisioPro2019$licType"; $productName = 'Visio Pro 2019'; $i++}
            if ($radioButton2019VisioStd.IsChecked -eq $true) {$productId = "VisioStd2019$licType"; $productName = 'Visio Standard 2019'; $i++}
            if ($radioButton2019Word.IsChecked -eq $true) {$productId = "Word2019$licType"; $productName = 'Microsoft Word 2019'; $i++}
            if ($radioButton2019Excel.IsChecked -eq $true) {$productId = "Excel2019$licType"; $productName = 'Microsoft Excel 2019'; $i++}
            if ($radioButton2019PowerPoint.IsChecked -eq $true) {$productId = "PowerPoint2019$licType"; $productName = 'Microsoft PowerPoint 2019'; $i++}
            if ($radioButton2019Outlook.IsChecked -eq $true) {$productId = "Outlook2019$licType"; $productName = 'Microsoft Outlook 2019'; $i++}
            if ($radioButton2019Publisher.IsChecked -eq $true) {$productId = "Publisher2019$licType"; $productName = 'Microsoft Publisher 2019'; $i++}
            if ($radioButton2019Access.IsChecked -eq $true) {$productId = "Access2019$licType"; $productName = 'Microsoft Access 2019'; $i++}
            if ($radioButton2019HomeBusiness.IsChecked -eq $true) {$productId = "HomeBusiness2019Retail"; $productName = 'Office HomeBusiness 2019'; $i++}
            if ($radioButton2019HomeStudent.IsChecked -eq $true) {$productId = "HomeStudent2019Retail"; $productName = 'Office HomeStudent 2019'; $i++}
 
         # For Office 2016
            if ($radioButton2016Pro.IsChecked -eq $true) {$productId = "ProfessionalRetail"; $uri = $uri2016; $productName = 'Office 2016 Professional Plus'; $i++}
            if ($radioButton2016Std.IsChecked -eq $true) {$productId = "StandardRetail"; $uri = $uri2016; $productName = 'Office 2016 Standard'; $i++}
            if ($radioButton2016ProjectPro.IsChecked -eq $true) {$productId = "ProjectProRetail"; $uri = $uri2016; $productName = 'Microsoft Project Pro 2016'; $i++}
            if ($radioButton2016ProjectStd.IsChecked -eq $true) {$productId = "ProjectStdRetail"; $uri = $uri2016; $productName = 'Microsoft Project Standard 2016'; $i++}
            if ($radioButton2016VisioPro.IsChecked -eq $true) {$productId = "VisioProRetail"; $uri = $uri2016; $productName = 'Microsoft Visio Pro 2016'; $i++}
            if ($radioButton2016VisioStd.IsChecked -eq $true) {$productId = "VisioStdRetail"; $uri = $uri2016; $productName = 'Microsoft Visio Standard 2016'; $i++}
            if ($radioButton2016Word.IsChecked -eq $true) {$productId = "WordRetail"; $uri = $uri2016; $productName = 'Microsoft Word 2016'; $i++}
            if ($radioButton2016Excel.IsChecked -eq $true) {$productId = "ExcelRetail"; $uri = $uri2016; $productName = 'Microsoft Excel 2016'; $i++}
            if ($radioButton2016PowerPoint.IsChecked -eq $true) {$productId = "PowerPointRetail"; $uri = $uri2016; $productName = 'Microsoft PowerPoint 2016'; $i++}
            if ($radioButton2016Outlook.IsChecked -eq $true) {$productId = "OutlookRetail"; $uri = $uri2016; $productName = 'Microsoft Outlook 2016'; $i++}
            if ($radioButton2016Publisher.IsChecked -eq $true) {$productId = "PublisherRetail"; $uri = $uri2016; $productName = 'Microsoft Publisher 2016'; $i++}
            if ($radioButton2016Access.IsChecked -eq $true) {$productId = "AccessRetail"; $uri = $uri2016; $productName = 'Microsoft Access 2016'; $i++}
            if ($radioButton2016OneNote.IsChecked -eq $true) {$productId = "OneNoteRetail"; $uri = $uri2016; $productName = 'Microsoft Onenote 2016'; $i++}
 
         # For Office 2013
            if ($radioButton2013Pro.IsChecked -eq $true) {$productId = "ProfessionalRetail"; $uri = $uri2013; $productName = 'Office 2013 Professional Plus'; $i++}
            if ($radioButton2013Std.IsChecked -eq $true) {$productId = "StandardRetail"; $uri = $uri2013; $productName = 'Office 2013 Standard'; $i++}
            if ($radioButton2013ProjectPro.IsChecked -eq $true) {$productId = "ProjectProRetail"; $uri = $uri2013; $productName = 'Microsoft Project Pro 2013'; $i++}
            if ($radioButton2013ProjectStd.IsChecked -eq $true) {$productId = "ProjectStdRetail"; $uri = $uri2013; $productName = 'Microsoft Project Standard 2013'; $i++}
            if ($radioButton2013VisioPro.IsChecked -eq $true) {$productId = "VisioProRetail"; $uri = $uri2013; $productName = 'Microsoft Visio Pro 2013'; $i++}
            if ($radioButton2013VisioStd.IsChecked -eq $true) {$productId = "VisioStdRetail"; $uri = $uri2013; $productName = 'Microsoft Visio Standard 2013'; $i++}
            if ($radioButton2013Word.IsChecked -eq $true) {$productId = "WordRetail"; $uri = $uri2013; $productName = 'Microsoft Word 2013'; $i++}
            if ($radioButton2013Excel.IsChecked -eq $true) {$productId = "ExcelRetail"; $uri = $uri2013; $productName = 'Microsoft Excel 2013'; $i++}
            if ($radioButton2013PowerPoint.IsChecked -eq $true) {$productId = "PowerPointRetail"; $uri = $uri2013; $productName = 'Microsoft PowerPoint 2013'; $i++}
            if ($radioButton2013Outlook.IsChecked -eq $true) {$productId = "OutlookRetail"; $uri = $uri2013; $productName = 'Microsoft Outlook 2013'; $i++}
            if ($radioButton2013Publisher.IsChecked -eq $true) {$productId = "PublisherRetail"; $uri = $uri2013; $productName = 'Microsoft Publisher 2013'; $i++}
            if ($radioButton2013Access.IsChecked -eq $true) {$productId = "AccessRetail"; $uri = $uri2013; $productName = 'Microsoft Access 2013'; $i++}
         # Update the shared hashtable
            $sync.arch = $arch
            $sync.mode = $mode
            $sync.language = $language
            $sync.UIstatus = $UIstatus
            $sync.productName = $productName
 
            if ($i -eq 1) {
                PreparingOffice
                Start-BackgroundOperation -Operation $DownloadInstallOffice
            } else {
                $progressbar.Visibility = "Collapsed"
                $textbox.Visibility = "Visible"
                $textbox.Foreground = "#FFC62828"
                $textbox.FontWeight = "Bold"
                $textbox.Text = "Please select an Office app before submitting."
            } 
    })

# Uninstall all installed Microsoft Office apps.
    $UninstallOffice = {
        trap {
            $sync.isBusy = $false
            $sync.errorMessage = $_.Exception.Message
            $sync.Form.Dispatcher.Invoke($sync.ShowErrorAction)
            continue
        }

        $sync.Form.Dispatcher.Invoke([action] { $sync.progressbar.Visibility = "Visible" })
        $sync.Form.Dispatcher.Invoke([action] { $sync.textbox.Visibility = "Visible" })
        $sync.Form.Dispatcher.Invoke([action] { $sync.textbox.Text = "Uninstalling Microsoft Office..." })
        $sync.Form.Dispatcher.Invoke([action] { $sync.buttonSubmit.Visibility = "Collapsed" })
        $sync.Form.Dispatcher.Invoke([action] { $sync.ProgressBar.BorderBrush = "#FF707070" })
        $sync.Form.Dispatcher.Invoke([action] { $sync.ProgressBar.IsIndeterminate = $true })
        
        Set-Location -Path $($sync.workingDir)
        Invoke-Item -Path $($sync.workingDir)
        # (New-Object Net.WebClient).DownloadFile($($sync.uninstall), "$($sync.workingDir)\04.Uninstall.bat")
        (New-Object Net.WebClient).DownloadFile($($sync.removeAllXML), "$($sync.workingDir)\configuration.xml")

        # Dynamically fetch the official Microsoft Office Deployment Tool (ODT) download page
        try {
            $odtPage = Invoke-WebRequest -Uri "https://www.microsoft.com/en-us/download/details.aspx?id=49117" -UseBasicParsing -TimeoutSec 15
            if ($odtPage.Content -match 'https://download\.microsoft\.com/download/[^\s"<>]+/officedeploymenttool[^\s"<>]*\.exe') {
                $odtUrl = $Matches[0]
            } else {
                $odtUrl = "https://download.microsoft.com/download/6/c/1/6c1eeb25-cf8b-41d9-8d0d-cc1dbc032140/officedeploymenttool_20228-20124.exe" # Fallback link
            }
        } catch {
            $odtUrl = "https://download.microsoft.com/download/6/c/1/6c1eeb25-cf8b-41d9-8d0d-cc1dbc032140/officedeploymenttool_20228-20124.exe" # Fallback link
        }

        # Download self-extracting ODT installer
        $odtFile = "$($sync.workingDir)\odt.exe"
        (New-Object Net.WebClient).DownloadFile($odtUrl, $odtFile)

        # Extract setup.exe (ClickToRun.exe) quietly from the ODT installer
        Start-Process -FilePath $odtFile -ArgumentList "/quiet /extract:`"$($sync.workingDir)`"" -Wait -NoNewWindow
        
        # Rename setup.exe to ClickToRun.exe as expected by the script
        if (Test-Path "$($sync.workingDir)\setup.exe") {
            Rename-Item -Path "$($sync.workingDir)\setup.exe" -NewName "ClickToRun.exe" -Force
        }
        if (Test-Path $odtFile) {
            Remove-Item $odtFile -Force
        }

        $sync.Form.Dispatcher.Invoke([action] { $sync.progressbar.Visibility = "Visible" })
        $sync.Form.Dispatcher.Invoke([action] { $sync.textbox.Visibility = "Visible" })
        $sync.Form.Dispatcher.Invoke([action] { $sync.textbox.Text = "Uninstalling Using Office Deployment Tool..." })
        $sync.Form.Dispatcher.Invoke([action] { $sync.buttonSubmit.Visibility = "Collapsed" })
        $sync.Form.Dispatcher.Invoke([action] { $sync.ProgressBar.BorderBrush = "#FF707070" })
        $sync.Form.Dispatcher.Invoke([action] { $sync.ProgressBar.IsIndeterminate = $true })

        # Start-Process -FilePath .\04.Uninstall.bat -Wait
        Start-Process -FilePath .\ClickToRun.exe -ArgumentList "/configure .\configuration.xml" -NoNewWindow -Wait

        if (Test-Path -Path "C:\Program Files*\Microsoft Office\Office15\ospp.vbs") {
            (New-Object Net.WebClient).DownloadFile('https://aka.ms/SaRA_EnterpriseVersionFiles', "$($sync.workingDir)\SaRA.zip")
            Expand-Archive -Path .\SaRA.zip -DestinationPath .\SaRA

            $sync.Form.Dispatcher.Invoke([action] { $sync.progressbar.Visibility = "Visible" })
            $sync.Form.Dispatcher.Invoke([action] { $sync.textbox.Visibility = "Visible" })
            $sync.Form.Dispatcher.Invoke([action] { $sync.textbox.Text = "Running Scenario OfficeScrubScenario..." })
            $sync.Form.Dispatcher.Invoke([action] { $sync.buttonSubmit.Visibility = "Collapsed" })
            $sync.Form.Dispatcher.Invoke([action] { $sync.ProgressBar.BorderBrush = "#FF707070" })
            $sync.Form.Dispatcher.Invoke([action] { $sync.ProgressBar.IsIndeterminate = $true })

            Start-Process -FilePath ".\SaRA\SaRACmd.exe" -ArgumentList "-S OfficeScrubScenario -AcceptEula -OfficeVersion All" -NoNewWindow -Wait
        }

        $sync.Form.Dispatcher.Invoke([action] { $sync.buttonSubmit.Visibility = 'Visible' })
        $sync.Form.Dispatcher.Invoke([action] { $sync.buttonSubmit.Content = 'Submit' })
        $sync.Form.Dispatcher.Invoke([action] { $sync.textbox.Visibility = 'Collapsed' })
        $sync.Form.Dispatcher.Invoke([action] { $sync.ProgressBar.Visibility = 'Collapsed' })
        $sync.Form.Dispatcher.Invoke([action] { $sync.ProgressBar.Value = '0' })
        $sync.isBusy = $false
        $sync.Form.Dispatcher.Invoke($sync.RestoreUiAction)

        # Cleanup
        Set-Location ..
        Remove-Item ClickToRunU -Recurse -Force
    }

    $buttonRemoveAll.Add_Click({
        if ($sync.isBusy) {
            return
        }

        if ($radioButtonRemoveAllApp.IsChecked) {
            $workingDir = New-Item -Path $env:temp\ClickToRunU -ItemType Directory -Force
            Set-Location $workingDir
            $sync.workingDir = $workingDir
            $sync.uri = $uri
            $sync.removeAllXML = $removeAllXML

            Start-BackgroundOperation -Operation $UninstallOffice
        }
    })

    $Form.Add_Closing({
        if ($sync.lastPowerShell) {
            try { $sync.lastPowerShell.Dispose() } catch {}
            $sync.lastPowerShell = $null
        }
        if ($runspace) {
            try { $runspace.Close() } catch {}
            try { $runspace.Dispose() } catch {}
        }
    })

$null = $Form.ShowDialog()






