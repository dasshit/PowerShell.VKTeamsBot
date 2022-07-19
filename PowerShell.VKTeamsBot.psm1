class VKTeamsBot
{
    [ValidatePattern("(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})")]
    [string] $API_URL = 'https://api.internal.myteam.mail.ru/bot/v1/'
    [ValidatePattern("\d+\.\d+\.\d+\:\d+")]
    [string] $TOKEN
	[ValidateSet('MarkdownV2', 'HTML')]
	[string] $parseMode = 'HTML'
	[int] $pollTime = 5
	[int] $lastEventId = 0

	VKTeamsBot(
			[string]$API_URL = 'https://api.internal.myteam.mail.ru/bot/v1/',
			[string]$TOKEN
	)
	{
		$this.API_URL = $API_URL
		$this.TOKEN = $TOKEN
	}

	VKTeamsBot(
			[string]$API_URL = 'https://api.internal.myteam.mail.ru/bot/v1/',
			[string]$TOKEN,
			[string]$parseMode
	)
	{
		$this.API_URL = $API_URL
		$this.TOKEN = $TOKEN
		$this.parseMode = $parseMode
	}

	[PSCustomObject]
	SelfGet()
	{
		$Parameters = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
		$Parameters['token'] = $this.TOKEN

		$Request = [System.UriBuilder]"$( $this.API_URL )self/get"
		$Request.Query = $Parameters.ToString()

		return Invoke-RestMethod -Uri $Request.Uri
	}

	[PSCustomObject]
	SendText(
			[string] $chatId,
			[string] $text
	)
	{
		$Parameters = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
		$Parameters['token'] = $this.TOKEN
		$Parameters['chatId'] = $chatId
		$Parameters['text'] = $text
		$Parameters['parseMode'] = $this.parseMode

		$Request = [System.UriBuilder]"$( $this.API_URL )messages/sendText"

		$Request.Query = $Parameters.ToString()

		return Invoke-RestMethod -Uri $Request.Uri
	}

	[PSCustomObject]
	SendFileById(
			[string] $chatId,
			[string] $fileId,
			[string] $caption = $null
	)
	{
		$Parameters = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
		$Parameters['token'] = $this.TOKEN
		$Parameters['chatId'] = $chatId
		$Parameters['caption'] = $caption
		$Parameters['fileId'] = $fileId
		$Parameters['parseMode'] = $this.parseMode

		$Request = [System.UriBuilder]"$( $this.API_URL )messages/sendFile"

		$Request.Query = $Parameters.ToString()

		return Invoke-RestMethod -Uri $Request.Uri
	}

	[PSCustomObject]
	SendFileByPath(
			[string] $chatId,
			[System.IO.FileInfo] $FilePath,
			[string] $caption = $null
	)
	{

		$Parameters = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
		$Parameters['token'] = $this.TOKEN
		$Parameters['chatId'] = $chatId
		$Parameters['caption'] = $caption
		$Parameters['parseMode'] = $this.parseMode

		$Request = [System.UriBuilder]"$( $this.API_URL )messages/sendFile"

		$Request.Query = $Parameters.ToString()

		$FileName = $FilePath.Name
		$FilePath = Join-Path -Path $PSScriptRoot -ChildPath $FileName

		$fileBytes = [System.IO.File]::ReadAllBytes($FilePath);
		$fileEnc = [System.Text.Encoding]::GetEncoding('UTF-8').GetString($fileBytes);
		$boundary = [System.Guid]::NewGuid().ToString();
		$LF = "`r`n";

		$bodyLines = (
		"--$boundary",
		"Content-Disposition: form-data; name=file; filename=$FileName",
		"Content-Type: application/octet-stream$LF",
		$fileEnc,
		"--$boundary--$LF"
		) -join $LF

		return $( Invoke-RestMethod -Uri $Request.Uri -Method Post -ContentType "multipart/form-data; boundary=$boundary" -Body $bodyLines )
	}

	[PSCustomObject]
	SendVoiceById(
			[string] $chatId,
			[string] $fileId,
			[string] $caption = $null
	)
	{
		$Parameters = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
		$Parameters['token'] = $this.TOKEN
		$Parameters['chatId'] = $chatId
		$Parameters['caption'] = $caption
		$Parameters['fileId'] = $fileId
		$Parameters['parseMode'] = $this.parseMode

		$Request = [System.UriBuilder]"$( $this.API_URL )messages/sendVoice"

		$Request.Query = $Parameters.ToString()

		return Invoke-RestMethod -Uri $Request.Uri
	}

	[PSCustomObject]
	SendVoiceByPath(
			[string] $chatId,
			[System.IO.FileInfo] $FilePath,
			[string] $caption = $null
	)
	{

		$Parameters = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
		$Parameters['token'] = $this.TOKEN
		$Parameters['chatId'] = $chatId
		$Parameters['caption'] = $caption
		$Parameters['parseMode'] = $this.parseMode

		$Request = [System.UriBuilder]"$( $this.API_URL )messages/sendVoice"

		$Request.Query = $Parameters.ToString()

		$FileName = $FilePath.Name
		$FilePath = Join-Path -Path $PSScriptRoot -ChildPath $FileName

		$fileBytes = [System.IO.File]::ReadAllBytes($FilePath);
		$fileEnc = [System.Text.Encoding]::GetEncoding('UTF-8').GetString($fileBytes);
		$boundary = [System.Guid]::NewGuid().ToString();
		$LF = "`r`n";

		$bodyLines = (
		"--$boundary",
		"Content-Disposition: form-data; name=file; filename=$FileName",
		"Content-Type: application/octet-stream$LF",
		$fileEnc,
		"--$boundary--$LF"
		) -join $LF

		return $( Invoke-RestMethod -Uri $Request.Uri -Method Post -ContentType "multipart/form-data; boundary=$boundary" -Body $bodyLines )
	}

	[PSCustomObject]
	EditText(
			[string] $chatId,
			[string] $msgId,
			[string] $text
	)
	{
		$Parameters = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
		$Parameters['token'] = $this.TOKEN
		$Parameters['chatId'] = $chatId
		$Parameters['msgId'] = $msgId
		$Parameters['text'] = $text
		$Parameters['parseMode'] = $this.parseMode

		$Request = [System.UriBuilder]"$( $this.API_URL )messages/editText"

		$Request.Query = $Parameters.ToString()

		return Invoke-RestMethod -Uri $Request.Uri
	}

	[PSCustomObject]
	DeleteMessages(
			[string] $chatId,
			[string[]] $msgId
	)
	{
		$Parameters = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
		$Parameters['token'] = $this.TOKEN
		$Parameters['chatId'] = $chatId
		$Parameters['msgId'] = $msgId
		$Parameters['parseMode'] = $this.parseMode

		$Request = [System.UriBuilder]"$( $this.API_URL )messages/deleteMessages"

		$Request.Query = $Parameters.ToString()

		return Invoke-RestMethod -Uri $Request.Uri
	}

	[PSCustomObject]
	AnswerCallbackQuery(
			[string] $queryId,
			[string] $text,
			[boolean] $showAlert,
			[string] $url
	)
	{
		$Parameters = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
		$Parameters['token'] = $this.TOKEN
		$Parameters['queryId'] = $queryId
		$Parameters['text'] = $text
		$Parameters['showAlert'] = $this.showAlert
		$Parameters['url'] = $this.url

		$Request = [System.UriBuilder]"$( $this.API_URL )messages/answerCallbackQuery"

		$Request.Query = $Parameters.ToString()

		return Invoke-RestMethod -Uri $Request.Uri
	}

	[PSCustomObject]
	CreateChat(
			[string] $name,
			[string] $about,
			[string] $rules,
			[string] $members,
			[boolean] $public,
			[string] $defaultRole,
			[boolean] $joinModeration
	)
	{
		$Parameters = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
		$Parameters['token'] = $this.TOKEN
		$Parameters['name'] = $name
		$Parameters['about'] = $about
		$Parameters['rules'] = $rules
		$Parameters['members'] = $members
		$Parameters['public'] = $public
		$Parameters['defaultRole'] = $defaultRole
		$Parameters['joinModeration'] = $joinModeration

		$Request = [System.UriBuilder]"$( $this.API_URL )chats/createChat"

		$Request.Query = $Parameters.ToString()

		return Invoke-RestMethod -Uri $Request.Uri
	}

	[PSCustomObject]
	MembersAdd(
			[string] $chatId,
			[string] $members
	)
	{
		$Parameters = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
		$Parameters['token'] = $this.TOKEN
		$Parameters['chatId'] = $chatId
		$Parameters['members'] = $members

		$Request = [System.UriBuilder]"$( $this.API_URL )chats/members/add"

		$Request.Query = $Parameters.ToString()

		return Invoke-RestMethod -Uri $Request.Uri
	}

	[PSCustomObject]
	MembersDelete(
			[string] $chatId,
			[string] $members
	)
	{
		$Parameters = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
		$Parameters['token'] = $this.TOKEN
		$Parameters['chatId'] = $chatId
		$Parameters['members'] = $members

		$Request = [System.UriBuilder]"$( $this.API_URL )chats/members/delete"

		$Request.Query = $Parameters.ToString()

		return Invoke-RestMethod -Uri $Request.Uri
	}

	[PSCustomObject]
	SetChatAvatar(
			[string] $chatId,
			[System.IO.FileInfo] $FilePath
	)
	{

		$Parameters = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
		$Parameters['token'] = $this.TOKEN
		$Parameters['chatId'] = $chatId

		$Request = [System.UriBuilder]"$( $this.API_URL )chats/avatar/set"

		$Request.Query = $Parameters.ToString()

		$FileName = $FilePath.Name
		$FilePath = "$PSScriptRoot\$FileName"

		$fileBytes = [System.IO.File]::ReadAllBytes($FilePath);
		$fileEnc = [System.Text.Encoding]::GetEncoding('UTF-8').GetString($fileBytes);
		$boundary = [System.Guid]::NewGuid().ToString();
		$LF = "`r`n";

		$bodyLines = (
		"--$boundary",
		"Content-Disposition: form-data; name=file; filename=$FileName",
		"Content-Type: application/octet-stream$LF",
		$fileEnc,
		"--$boundary--$LF"
		) -join $LF

		return $( Invoke-RestMethod -Uri $Request.Uri -Method Post -ContentType "multipart/form-data; boundary=$boundary" -Body $bodyLines )
	}

	[PSCustomObject]
	SendChatActions(
			[string] $chatId,
			[string[]] $actions
	)
	{
		$Parameters = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
		$Parameters['token'] = $this.TOKEN
		$Parameters['chatId'] = $chatId
		$Parameters['actions'] = $actions

		$Request = [System.UriBuilder]"$( $this.API_URL )chats/sendActions"

		$Request.Query = $Parameters.ToString()

		return Invoke-RestMethod -Uri $Request.Uri
	}

	[PSCustomObject]
	GetChatInfo(
			[string] $chatId
	)
	{
		$Parameters = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
		$Parameters['token'] = $this.TOKEN
		$Parameters['chatId'] = $chatId

		$Request = [System.UriBuilder]"$( $this.API_URL )chats/getInfo"

		$Request.Query = $Parameters.ToString()

		return Invoke-RestMethod -Uri $Request.Uri
	}

	[PSCustomObject]
	GetChatAdmins(
			[string] $chatId
	)
	{
		$Parameters = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
		$Parameters['token'] = $this.TOKEN
		$Parameters['chatId'] = $chatId

		$Request = [System.UriBuilder]"$( $this.API_URL )chats/getAdmins"

		$Request.Query = $Parameters.ToString()

		return Invoke-RestMethod -Uri $Request.Uri
	}

	[PSCustomObject]
	GetChatMembers(
			[string] $chatId,
			[string] $cursor
	)
	{
		$Parameters = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
		$Parameters['token'] = $this.TOKEN
		$Parameters['chatId'] = $chatId
		$Parameters['cursor'] = $cursor

		$Request = [System.UriBuilder]"$( $this.API_URL )chats/getMembers"

		$Request.Query = $Parameters.ToString()

		return Invoke-RestMethod -Uri $Request.Uri
	}

	[PSCustomObject]
	GetChatBlockedUsers(
			[string] $chatId
	)
	{
		$Parameters = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
		$Parameters['token'] = $this.TOKEN
		$Parameters['chatId'] = $chatId

		$Request = [System.UriBuilder]"$( $this.API_URL )chats/getBlockedUsers"

		$Request.Query = $Parameters.ToString()

		return Invoke-RestMethod -Uri $Request.Uri
	}

	[PSCustomObject]
	GetChatPendingUsers(
			[string] $chatId
	)
	{
		$Parameters = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
		$Parameters['token'] = $this.TOKEN
		$Parameters['chatId'] = $chatId

		$Request = [System.UriBuilder]"$( $this.API_URL )chats/getPendingUsers"

		$Request.Query = $Parameters.ToString()

		return Invoke-RestMethod -Uri $Request.Uri
	}

	[PSCustomObject]
	BlockChatUser(
			[string] $chatId,
			[string] $userId,
			[boolean] $delLastMessages
	)
	{
		$Parameters = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
		$Parameters['token'] = $this.TOKEN
		$Parameters['chatId'] = $chatId
		$Parameters['userId'] = $userId
		$Parameters['delLastMessages'] = $delLastMessages

		$Request = [System.UriBuilder]"$( $this.API_URL )chats/blockUser"

		$Request.Query = $Parameters.ToString()

		return Invoke-RestMethod -Uri $Request.Uri
	}

	[PSCustomObject]
	UnblockChatUser(
			[string] $chatId,
			[string] $userId
	)
	{
		$Parameters = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
		$Parameters['token'] = $this.TOKEN
		$Parameters['chatId'] = $chatId
		$Parameters['userId'] = $userId

		$Request = [System.UriBuilder]"$( $this.API_URL )chats/unblockUser"

		$Request.Query = $Parameters.ToString()

		return Invoke-RestMethod -Uri $Request.Uri
	}

	[PSCustomObject]
	ResolvePendingChatUsers(
			[string] $chatId,
			[boolean] $approve,
			[string] $userId,
			[boolean] $everyone
	)
	{
		$Parameters = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
		$Parameters['token'] = $this.TOKEN
		$Parameters['chatId'] = $chatId
		$Parameters['approve'] = $approve
		$Parameters['userId'] = $userId
		$Parameters['everyone'] = $everyone

		$Request = [System.UriBuilder]"$( $this.API_URL )chats/resolvePending"

		$Request.Query = $Parameters.ToString()

		return Invoke-RestMethod -Uri $Request.Uri
	}

	[PSCustomObject]
	SetChatTitle(
			[string] $chatId,
			[string] $title
	)
	{
		$Parameters = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
		$Parameters['token'] = $this.TOKEN
		$Parameters['chatId'] = $chatId
		$Parameters['title'] = $title

		$Request = [System.UriBuilder]"$( $this.API_URL )chats/setTitle"

		$Request.Query = $Parameters.ToString()

		return Invoke-RestMethod -Uri $Request.Uri
	}

	[PSCustomObject]
	SetChatAbout(
			[string] $chatId,
			[string] $about
	)
	{
		$Parameters = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
		$Parameters['token'] = $this.TOKEN
		$Parameters['chatId'] = $chatId
		$Parameters['about'] = $about

		$Request = [System.UriBuilder]"$( $this.API_URL )chats/setAbout"

		$Request.Query = $Parameters.ToString()

		return Invoke-RestMethod -Uri $Request.Uri
	}

	[PSCustomObject]
	SetChatRules(
			[string] $chatId,
			[string] $rules
	)
	{
		$Parameters = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
		$Parameters['token'] = $this.TOKEN
		$Parameters['chatId'] = $chatId
		$Parameters['rules'] = $rules

		$Request = [System.UriBuilder]"$( $this.API_URL )chats/setRules"

		$Request.Query = $Parameters.ToString()

		return Invoke-RestMethod -Uri $Request.Uri
	}

	[PSCustomObject]
	PinChatMessage(
			[string] $chatId,
			[string] $msgId
	)
	{
		$Parameters = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
		$Parameters['token'] = $this.TOKEN
		$Parameters['chatId'] = $chatId
		$Parameters['msgId'] = $msgId

		$Request = [System.UriBuilder]"$( $this.API_URL )chats/pinMessage"

		$Request.Query = $Parameters.ToString()

		return Invoke-RestMethod -Uri $Request.Uri
	}

	[PSCustomObject]
	UnpinChatMessage(
			[string] $chatId,
			[string] $msgId
	)
	{
		$Parameters = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
		$Parameters['token'] = $this.TOKEN
		$Parameters['chatId'] = $chatId
		$Parameters['msgId'] = $msgId

		$Request = [System.UriBuilder]"$( $this.API_URL )chats/unpinMessage"

		$Request.Query = $Parameters.ToString()

		return Invoke-RestMethod -Uri $Request.Uri
	}

	[PSCustomObject]
	GetFileInfo(
			[string] $fileId
	)
	{
		$Parameters = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
		$Parameters['token'] = $this.TOKEN
		$Parameters['fileId'] = $fileId

		$Request = [System.UriBuilder]"$( $this.API_URL )files/getInfo"

		$Request.Query = $Parameters.ToString()

		return Invoke-RestMethod -Uri $Request.Uri
	}

	[PSCustomObject]
	EventsGet()
	{
		$Parameters = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
		$Parameters['token'] = $this.TOKEN
		$Parameters['lastEventId'] = $this.lastEventId
		$Parameters['pollTime'] = $this.pollTime

		$Request = [System.UriBuilder]"$( $this.API_URL )events/get"

		$Request.Query = $Parameters.ToString()

		$Response = Invoke-RestMethod -Uri $Request.Uri

		if ($Response.events.count -ne 0)
		{
			$this.lastEventId = $Response.events[-1].eventId
		}
		return $Response.events
	}
}


function New-VKTeamsBot(
		[string]$API_URL = 'https://api.internal.myteam.mail.ru/bot/v1/',
		[string]$TOKEN,
		[string]$parseMode = "HTML"
)
{
	return [VKTeamsBot]::new($API_URL, $TOKEN, $parseMode)
}


Export-ModuleMember -Function New-VKTeamsBot