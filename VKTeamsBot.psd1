#
# Манифест модуля для модуля "VKTeamsBot".
#
# Создано: v.korobov@corp.mail.ru
#
# Дата создания: 02.07.2022
#

@{

# Файл модуля сценария или двоичного модуля, связанный с этим манифестом.
RootModule = 'VKTeamsBot.psm1'

# Номер версии данного модуля.
ModuleVersion = '1.0'

# Поддерживаемые выпуски PSEditions
# CompatiblePSEditions = @()

# Уникальный идентификатор данного модуля
GUID = '6a496d01-ff8c-4271-8a85-1e41d1d140ae'

# Автор данного модуля
Author = 'v.korobov@corp.mail.ru'

# Компания, создавшая данный модуль, или его поставщик
CompanyName = 'Неизвестно'

# Заявление об авторских правах на модуль
Copyright = '(c) 2022 v.korobov@corp.mail.ru. Все права защищены.'

# Описание функций данного модуля
# Description = ''

# Минимальный номер версии обработчика Windows PowerShell, необходимой для работы данного модуля
# PowerShellVersion = ''

# Имя узла Windows PowerShell, необходимого для работы данного модуля
# PowerShellHostName = ''

# Минимальный номер версии узла Windows PowerShell, необходимой для работы данного модуля
# PowerShellHostVersion = ''

# Минимальный номер версии Microsoft .NET Framework, необходимой для данного модуля. Это обязательное требование действительно только для выпуска PowerShell, предназначенного для компьютеров.
# DotNetFrameworkVersion = ''

# Минимальный номер версии среды CLR (общеязыковой среды выполнения), необходимой для работы данного модуля. Это обязательное требование действительно только для выпуска PowerShell, предназначенного для компьютеров.
# CLRVersion = ''

# Архитектура процессора (нет, X86, AMD64), необходимая для этого модуля
# ProcessorArchitecture = ''

# Модули, которые необходимо импортировать в глобальную среду перед импортированием данного модуля
# RequiredModules = @('System.Web')

# Сборки, которые должны быть загружены перед импортированием данного модуля
RequiredAssemblies = @('System.Web')

# Файлы сценария (PS1), которые запускаются в среде вызывающей стороны перед импортом данного модуля.
# ScriptsToProcess = @()

# Файлы типа (.ps1xml), которые загружаются при импорте данного модуля
# TypesToProcess = @()

# Файлы формата (PS1XML-файлы), которые загружаются при импорте данного модуля
# FormatsToProcess = @()

# Модули для импорта в качестве вложенных модулей модуля, указанного в параметре RootModule/ModuleToProcess
# NestedModules = @()

# В целях обеспечения оптимальной производительности функции для экспорта из этого модуля не используют подстановочные знаки и не удаляют запись. Используйте пустой массив, если нет функций для экспорта.
FunctionsToExport = @('New-VKTeamsBot')

# В целях обеспечения оптимальной производительности командлеты для экспорта из этого модуля не используют подстановочные знаки и не удаляют запись. Используйте пустой массив, если нет командлетов для экспорта.
CmdletsToExport = @()

# Переменные для экспорта из данного модуля
VariablesToExport = '*'

# В целях обеспечения оптимальной производительности псевдонимы для экспорта из этого модуля не используют подстановочные знаки и не удаляют запись. Используйте пустой массив, если нет псевдонимов для экспорта.
AliasesToExport = @()

# Ресурсы DSC для экспорта из этого модуля
# DscResourcesToExport = @()

# Список всех модулей, входящих в пакет данного модуля
# ModuleList = @()

# Список всех файлов, входящих в пакет данного модуля
# FileList = @()

# Личные данные для передачи в модуль, указанный в параметре RootModule/ModuleToProcess. Он также может содержать хэш-таблицу PSData с дополнительными метаданными модуля, которые используются в PowerShell.
PrivateData = @{

    PSData = @{

        # Теги, применимые к этому модулю. Они помогают с обнаружением модуля в онлайн-коллекциях.
        # Tags = @()

        # URL-адрес лицензии для этого модуля.
        # LicenseUri = ''

        # URL-адрес главного веб-сайта для этого проекта.
        # ProjectUri = ''

        # URL-адрес значка, который представляет этот модуль.
        # IconUri = ''

        # Заметки о выпуске этого модуля
        # ReleaseNotes = ''

    } # Конец хэш-таблицы PSData

} # Конец хэш-таблицы PrivateData

# Код URI для HelpInfo данного модуля
# HelpInfoURI = ''

# Префикс по умолчанию для команд, экспортированных из этого модуля. Переопределите префикс по умолчанию с помощью команды Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

