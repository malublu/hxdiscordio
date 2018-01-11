package npm.io;

/**
 * ...
 * @author MaLuBlu
 */


import js.Error;
import js.node.Buffer;
import js.node.events.EventEmitter;
import haxe.DynamicAccess;
import js.node.stream.Readable;

typedef DiscordEventData = {
	var t:String;
	var s:Int;
	var op:Int;
	var d:Dynamic;
};

typedef DiscordOnMessageEventDataAttachment = {
	var url:String;
	var size:Int;
	var proxy_url:String;
	var id:String;
	var filename:String;
	var width:Null<Int>;
	var height:Null<Int>;
};

typedef DiscordOnMessageEventData = {
	var t:String;
	var s:Int;
	var op:Int;
	var d:{
		var type:Int;
		var tts:Bool;
		var timestamp:String;
		var pinned:Bool;
		var nonce:Int;
		var mentions:Array<Dynamic>;
		var mention_roles:Array<Dynamic>;
		var mention_everyone:Bool;
		var id:String;
		var embeds:Array<Dynamic>;
		var edited_timestamp:Null<String>;
		var content:String;
		var channel_id:String;
		var author: {
			var username:String;
			var id:String;
			var discriminator:String;
			var avatar:String;
		};
		var attachments:Array<DiscordOnMessageEventDataAttachment>;
	};
};

typedef DiscordEmoji = Dynamic;
typedef DiscordFeatures = Dynamic;

typedef DiscordOptions = {
	var token:String;
	@:optional var autorun:Bool;
	@:optional var messageCacheLimit:Int;
	@:optional var shard:Array<Int>;
}

typedef DiscordGame = {
	var name:String;
	var type:Int;
	@:optional var url:String;
};

typedef DiscordRole = {
	var name:String;
	var id:String;
	var position:Int;
	var managed:Bool;
	var permissions:Int;
	var mentionable:Bool;
	var hoist:Bool;
	var color:Int;
};

typedef DiscordServer = {
	var name:String;
	var id:String;
	var region:String;
	var owner_id:String;
	var joined_at:String;
	var large:Bool;
	var verification_level:Int;
	@:optional var splash:String;
	@:optional var icon:String;
	var member_count:Int;
	var unavailable:Bool;
	var channels:DynamicAccess<DiscordChannel>;
	var members:DynamicAccess<DiscordMember>;
	var roles:DynamicAccess<DiscordRole>;
	var features:Array<DiscordFeatures>;
	var emojis:Array<DiscordEmoji>;
	var afk_timeout:Int;
	@:optional var afk_channel_id:String;
	var embed_enabled:Bool;
	@:optional var embed_channel_id:String;
	var default_message_notifications:Int;
};

typedef DiscordChannel = {
	var name:String;
	var id:String;
	var guild_id:String;
	var type:String;
	var topic:String;
	var position:Int;
	var permission_overwrites:Array< {
		var type:String;
		var id:String;
		var deny:Int;
		var allow:Int;
	} > ;
	var last_message_id:String;
	var members:DynamicAccess<DiscordMember>;
};

typedef DiscordMember = {
	var id:String;
	var roles:Array<String>;
	var mute:Bool;
	var joined_at:String;
	var deaf:Bool;
	var status:DiscordStatus;
	@:optional var voice_channel_id:String;
	@:optional var nick:String;
};

typedef DiscordUser = {
	var username:String;
	var id:String;
	var discriminator:Int;
	var avatar:String;
	var bot:Bool;
	var game:DiscordGame;
};

typedef DMChannel = {
	var recipient:DynamicAccess<DiscordUser>;
	var last_message_id:String;
	var id:String;
};

@:enum abstract DiscordEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	// event
    var Ready:DiscordEvent<DiscordEventData->Void> = "ready";
	var Disconnect:DiscordEvent<String->Int->Void> = "disconnect";
	// user, userID, channelID, message, event
	var Message:DiscordEvent<String->String->String->String->DiscordOnMessageEventData->Void> = "message";
	// user, userID, status, game, event
	var Presence:DiscordEvent<String->String->String->DiscordGame->DiscordEventData->Void> = "presence";
	var Any:DiscordEvent<DiscordEventData->Void> = "any";
	//MESSAGE_CREATE username, userID, channelID, message
	var MessageCreate:DiscordEvent<String->String->String->String->Void> = "messageCreate";
	//MESSAGE_UPDATE oldMsg?, newMsg
	var MessageUpdate:DiscordEvent<Null<String>->String->Void> = "messageUpdate";
	//PRESENCE_UPDATE
	var PresenceUpdate:DiscordEvent<Void->Void> = "presenceUpdate";
	//USER_UPDATE
	var UserUpdate:DiscordEvent<Void->Void> = "userUpdate";
	//USER_SETTINGS_UPDATE
	var UserSettingsUpdate:DiscordEvent<Void->Void> = "userSettingsUpdate";
	//GUILD_CREATE server
	var GuildCreate:DiscordEvent<DiscordServer->Void> = "guildCreate";
	//GUILD_UPDATE oldServer, newServer
	var GuildUpdate:DiscordEvent<DiscordServer->DiscordServer->Void> = "guildUpdate";
	//GUILD_DELETE server
	var GuildDelete:DiscordEvent<DiscordServer->Void> = "guildDelete";
	//GUILD_MEMBER_ADD member
	var GuildMemberAdd:DiscordEvent<DiscordMember->Void> = "guildMemberAdd";
	//GUILD_MEMBER_UPDATE oldMember, newMember
	var GuildMemberUpdate:DiscordEvent<DiscordMember->DiscordMember->Void> = "guildMemberUpdate";
	//GUILD_MEMBER_REMOVE member
	var GuildMemberRemove:DiscordEvent<DiscordMember->Void> = "guildMemberRemove";
	//GUILD_ROLE_CREATE role
	var GuildRoleCreate:DiscordEvent<DiscordRole->Void> = "guildRoleCreate";
	//GUILD_ROLE_UPDATE oldRole, newRole
	var GuildRoleUpdate:DiscordEvent<DiscordRole->DiscordRole->Void> = "guildRoleUpdate";
	//GUILD_ROLE_DELETE role
	var GuildRoleDelete:DiscordEvent<DiscordRole->Void> = "guildRoleDelete";
	//CHANNEL_CREATE channel
	var ChannelCreate:DiscordEvent<DiscordChannel->Void> = "channelCreate";
	//CHANNEL_UPDATE oldChannel, newChannel
	var ChannelUpdate:DiscordEvent<DiscordChannel->DiscordChannel->Void> = "channelUpdate";
	//CHANNEL_DELETE channel
	var ChannelDelete:DiscordEvent<DiscordChannel->Void> = "channelDelete";
	//VOICE_STATE_UPDATE
	var VoiceStateUpdate:DiscordEvent<Void->Void> = "voiceStateUpdate";
	//VOICE_SERVER_UPDATE
	var VoiceServerUpdate:DiscordEvent<Void->Void> = "voiceServerUpdate";
	//GUILD_MEMBERS_CHUNK
	var GuildMembersChunk:DiscordEvent<Void->Void> = "guildMembersChunk";
	
	
	var Speaking:DiscordEvent<String->Buffer->Bool->Void> = "speaking";
	
	var Done:DiscordEvent<Void->Void> = "done";
}

@:enum
abstract DiscordRegions (String) to String {
	var Brazil = "brazil";
	var Frankfurt = "frankfurt";
	var Amsterdam = "amsterdam";
	var London = "london";
	var Singapore = "singapore";
	var UsEeast = "us-east";
	var UsCentral = "us-central";
	var UsSouth = "us-south";
	var UsWest = "us-west";
	var Sydney = "sydney";
}

@:enum
abstract DiscordStatus (String) to String {
	var Online = "online";
	var Idle = "idle";
	var Offline = "offline";
}

@:enum
abstract DiscordAfkTimeOut (Int) to Int {
	var S60 = 60;
	var S300 = 300;
	var S900 = 900;
	var S1800 = 1800;
	var S3600 = 3600;
}

@:enum
abstract DiscordInviteMaxUsers (Int) to Int {
	var UInivinity = 0;
	var U1 = 1;
	var U5 = 5;
	var U10 = 10;
	var U25 = 25;
	var U50 = 50;
	var U100 = 100;
}

@:enum
abstract DiscordInviteMaxAge (Int) to Int {
	var Inivinity = 0;
	var M30 = 1800;
	var H1 = 3600;
	var H6 = 21600;
	var H12 = 43200;
	var H24 = 86400;
}

typedef DiscordSetPermission = {
	@:optional var GENERAL_CREATE_INSTANT_INVITE:Bool;
	@:optional var GENERAL_KICK_MEMBERS:Bool;
	@:optional var GENERAL_BAN_MEMBERS:Bool;
	@:optional var GENERAL_MANAGE_ROLES:Bool;
	@:optional var GENERAL_MANAGE_CHANNELS:Bool;
	@:optional var GENERAL_MANAGE_GUILD:Bool;
	@:optional var GENERAL_ADMINISTRATOR:Bool;
	
	@:optional var TEXT_READ_MESSAGES:Bool;
	@:optional var TEXT_SEND_MESSAGES:Bool;
	@:optional var TEXT_SEND_TSS_MESSAGES:Bool;
	@:optional var TEXT_MANAGE_MESSAGES:Bool;
	@:optional var TEXT_EMBED_LINKS:Bool;
	@:optional var TEXT_ATTACH_FILES:Bool;
	@:optional var TEXT_READ_MESSAGE_HISTORY:Bool;
	@:optional var TEXT_MENTION_EVERYONE:Bool;
	
	@:optional var VOICE_CONNECT:Bool;
	@:optional var VOICE_SPEAK:Bool;
	@:optional var VOICE_MUTE_MEMBERS:Bool;
	@:optional var VOICE_DEAFEN_MEMBERS:Bool;
	@:optional var VOICE_MOVE_MEMBERS:Bool;
	@:optional var VOICE_USE_VAD:Bool;
};

typedef DiscordEmbedMessage = {
	@:optional var author:{
		@:optional var icon_url:String;
		var name:String;
		@:optional var url:String;
	};
	@:optional var color:Int;
	@:optional var description:String;
	@:optional var fields:Array < {
		var name:String;
		@:optional var value:String;
		// native not working in typedef
		// https://github.com/HaxeFoundation/haxe-evolution/pull/32
		// sendMessage(opts:{...var embed:Dynamic(DiscordEmbedMessage)
		@:native('inline') @:optional var isInline:Bool;
	} > ;
	@:optional var thumbnail: {
		var url:String;
	};
	var title:String;
	@:optional var timestamp:Date;
	@:optional var url:String;
	@:optional var footer: {
		@:optional var icon_url:String;
		var text:String;
	}
};

@:enum
abstract DiscordColor (Int) {
	var DEFAULT = 0;
	var AQUA = 1752220;
	var GREEN = 3066993;
	var BLUE = 3447003;
	var PURPLE = 10181046;
	var GOLD = 15844367;
	var ORANGE = 15105570;
	var RED = 15158332;
	var GREY = 9807270;
	var DARKER_GREY = 8359053;
	var NAVY = 3426654;
	var DARK_AQUA = 1146986;
	var DARK_GREEN = 2067276;
	var DARK_BLUE = 2123412;
	var DARK_PURPLE = 7419530;
	var DARK_GOLD = 12745742;
	var DARK_ORANGE = 11027200;
	var DARK_RED = 10038562;
	var DARK_GREY = 9936031;
	var LIGHT_GREY = 12370112;
	var DARK_NAVY = 2899536;
}

/*
typedef DiscordEmoji = {
	var name:String;
	var id:String;
};
*/

@:jsRequire("discord.io", "Client")
private extern class InternalDiscord extends EventEmitter<InternalDiscord> {
	public var id:String;
	public var username:String;
	public var email:String;
	public var discriminator:String;
	public var avatar:String;
	public var bot:Bool;
	public var verified:Bool;
	public var connected:Bool;
	public var presenceStatus:DiscordStatus;
	public var inviteURL:Null<String>;
	public var servers:DynamicAccess<DiscordServer>;
	public var channels:DynamicAccess<DiscordChannel>;
	public var users:DynamicAccess<DiscordUser>;
	public var directMessages:DynamicAccess<DMChannel>;
	public var internals:DynamicAccess<Dynamic>;
	
	public function new(options:DiscordOptions):Void;
	
	public function connect():Void;
	public function disconnect():Void;
	
	public function editUserInfo(opts:{var avatar:String; var email:String; var password:String; var new_password:String; var username:String;}, callback:Error -> DynamicAccess<Dynamic> -> Void):Void;
	public function setPresence(opts:{@:optional var idle_since:Int; var game:DiscordGame;}):Void;
	public function getOauthInfo(callback:Error -> String -> Void):Void;
	public function getAccountSettings(callback:Error -> DynamicAccess<Dynamic> -> Void):Void;
	public function getAllUsers(callback:Error -> Void):Void;
	public function fixMessage(message:String):Void;
	
	public function createServer(opts:{@:optional var icon:String; var name:String; @:optional var region:DiscordRegions;}, callback:Error -> DynamicAccess<Dynamic> -> Void):Void;
	public function editServer(opts:{var serverID:String; var name:String; @:optional var icon:String; var region:DiscordRegions; @:optional var afk_channel_id:String; @:optional var afk_timeout:DiscordAfkTimeOut;}, callback:Error -> DynamicAccess<Dynamic> -> Void):Void;
	//public function editServerWidget(opts:{var serverID:String; @:optional var enabled:Bool; @:optional var channelID:String; }, callback:Error -> DynamicAccess<Dynamic> -> Void):Void;
	public function leaveServer(serverID:String, callback:Error -> DynamicAccess<Dynamic> -> Void):Void;
	public function deleteServer(serverID:String, callback:Error -> DynamicAccess<Dynamic> -> Void):Void;
	public function transferOwnership(opts:{var serverID:String; var userID:String; }, callback:Error -> DynamicAccess<Dynamic> -> Void):Void;
	public function acceptInvite(serverID:String, callback:Error -> DynamicAccess<Dynamic> -> Void):Void;
	public function createInvite(opts:{var channelID:String; var max_users:DiscordInviteMaxUsers; var max_age:DiscordInviteMaxAge; var temporary:Bool; }, callback:Error -> DynamicAccess<Dynamic> -> Void):Void;
	public function deleteInvite(inviteCode:String, callback:Error -> DynamicAccess<Dynamic> -> Void):Void;
	public function queryInvite(inviteCode:String, callback:Error -> {var id:String; var name:String; var type:String; } -> Void):Void;
	public function createRole(inviteCode:String, callback:Error -> DynamicAccess<Dynamic> -> Void):Void;
	public function editRole(opts:{var serverID:String; var roleID:String; var name:String; var color:Int; var hoist:Bool; var permissions:DiscordSetPermission; var mentionable:Bool; }, callback:Error -> DynamicAccess<Dynamic> -> Void):Void;

	public function sendMessage(opts:{var to:String; @:optional var message:String; @:optional var tts:Bool; @:optional var nonce:Int; @:optional var typing:Bool; @:optional var embed:Dynamic; }, callback:Error -> DynamicAccess<Dynamic> -> Void):Void;
	public function uploadFile(opts:{var to:String; var file:haxe.extern.EitherType<String, Buffer>; @:optional var filename:String; @:optional var message:String; }, callback:Error -> DynamicAccess<Dynamic> -> Void):Void;
	public function getMessage(opts:{var channelID:String; var messageID:String; }, callback:Error -> DynamicAccess<Dynamic> -> Void):Void;
	public function getMessages(opts:{var channelID:String; var before:String; var after:String; @:optional var limit:Int; }, callback:Error -> DynamicAccess<Dynamic> -> Void):Void;
	public function editMessage(opts:{var channelID:String; var messageID:String; var message:String;}, callback:Error -> DynamicAccess<Dynamic> -> Void):Void;
	public function simulateTyping(channelID:String, callback:Error -> DynamicAccess<Dynamic> -> Void):Void;
	public function deleteMessages(opts:{var channelID:String; var messageIDs:Array<String>;}, callback:Error -> DynamicAccess<Dynamic> -> Void):Void;
	public function deleteMessage(opts:{var channelID:String; var messageID:String; }, callback:Error -> Void):Void;
	public function pinMessage(opts:{var channelID:String; var messageIDs:Array<String>;}, callback:Error -> DynamicAccess<Dynamic> -> Void):Void;
	public function deletePinnedMessage(opts:{var channelID:String; var messageIDs:Array<String>;}, callback:Error -> DynamicAccess<Dynamic> -> Void):Void;
	public function getPinnedMessages(opts:{var channelID:String; var messageID:String; }, callback:Error -> DynamicAccess<Dynamic> -> Void):Void;
	//public function addReaction(opts:{var channelID:String; var messageID:String; var reaction:haxe.extern.EitherType<String, DiscordEmoji>; }, callback:Error -> DynamicAccess<Dynamic> -> Void):Void;
	//public function getReaction(opts:{var channelID:String; var messageID:String; var reaction:haxe.extern.EitherType<String, DiscordEmoji>; @:optional var limit:Int; }, callback:Error -> DynamicAccess<Dynamic> -> Void):Void;
	//public function removeReaction(opts:{var channelID:String; var messageID:String; @:optional var userID; var reaction:haxe.extern.EitherType<String, DiscordEmoji>; }, callback:Error -> DynamicAccess<Dynamic> -> Void):Void;
	//public function removeAllReactions(opts:{var channelID:String; var messageID:String; }, callback:Error -> DynamicAccess<Dynamic> -> Void):Void;
	
	//public function addServerEmoji(opts:{var serverID:String; var name:String; var icon:Buffer; }, callback:Error -> DynamicAccess<Dynamic> -> Void):Void;
	
	public function joinVoiceChannel(channelID:String, callback:Error -> Void):Void;
	public function leaveVoiceChannel(channelID:String, callback:Void -> Void):Void;
	// https://izy521.gitbooks.io/discord-io/content/Methods/Handling_audio.html
	public function getAudioContext(channelID:String, callback:Error -> Readable<Dynamic> -> Void):Void;
	public function createDMChannel(userID:String, callback:Error -> DynamicAccess<Dynamic> -> Void):Void;
	public function editNickname(opts:{var serverID:String;var userID:String;var nick:String;}, callback:Error -> DynamicAccess<Dynamic> -> Void):Void;
	public function addToRole(opts:{var serverID:String;var userID:String;var roleID:String;}, callback:Error -> DynamicAccess<Dynamic> -> Void):Void;
	public function removeFromRole(opts:{var serverID:String;var userID:String;var roleID:String;}, callback:Error -> DynamicAccess<Dynamic> -> Void):Void;
	public function moveUserTo(opts:{var serverID:String;var userID:String;var channelID:String;}, callback:Error -> Void):Void;
	public function kick(opts:{var serverID:String;var userID:String;}, callback:Error -> Void):Void;
	public function ban(opts:{var serverID:String; var userID:String; @:optional var lastDays:Int; }, callback:Error -> Void):Void;
	public function unban(opts:{var serverID:String;var userID:String; }, callback:Error -> Void):Void;
	public function mute(opts:{var serverID:String;var userID:String; }, callback:Error -> Void):Void;
	public function unmute(opts:{var serverID:String;var userID:String; }, callback:Error -> Void):Void;
	public function deafen(opts:{var serverID:String;var userID:String; }, callback:Error -> Void):Void;
	public function undeafen(opts:{var serverID:String; var userID:String; }, callback:Error -> Void):Void;
}

@:enum
abstract DiscordPermission (Int) to Int {
	var CREATE_INSTANT_INVITE = 0x00000001;
	var KICK_MEMBERS = 0x00000002;
	var BAN_MEMBERS = 0x00000004;
	var ADMINISTRATOR = 0x00000008;
	var MANAGE_CHANNELS = 0x00000010;
	var MANAGE_GUILD = 0x00000020;
	var ADD_REACTIONS = 0x00000040;
	var VIEW_AUDIT_LOG = 0x00000080;
	var VIEW_CHANNEL = 0x00000400;
	var SEND_MESSAGES = 0x00000800;
	var SEND_TTS_MESSAGES = 0x00001000;
	var MANAGE_MESSAGES = 0x00002000;
	var EMBED_LINKS = 0x00004000;
	var ATTACH_FILES = 0x00008000;
	var READ_MESSAGE_HISTORY = 0x00010000;
	var MENTION_EVERYONE = 0x00020000;
	var USE_EXTERNAL_EMOJIS = 0x00040000;
	var CONNECT = 0x00100000;
	var SPEAK = 0x00200000;
	var MUTE_MEMBERS = 0x00400000;
	var DEAFEN_MEMBERS = 0x00800000;
	var MOVE_MEMBERS = 0x01000000;
	var USE_VAD = 0x02000000;
	var CHANGE_NICKNAME = 0x04000000;
	var MANAGE_NICKNAMES = 0x08000000;
	var MANAGE_ROLES = 0x10000000;
	var MANAGE_WEBHOOKS = 0x20000000;
	var MANAGE_EMOJIS = 0x40000000;
}

@:enum
abstract DiscordOAuth2Scope (String) to String {
	var Bot = 'bot';
	var connections = 'connections';
	var email = 'email';
	var identify = 'identify';
	var guilds = 'guilds';
	var guilds_join = 'guilds.join';
	var gdm_join = 'gdm.join';
	var messages_read = 'messages.read';
	var rpc = 'rpc';
	var rpc_api = 'rpc.api';
	var rpc_notifications_read = 'rpc.notifications.read';
	var webhook_incoming = 'webhook.incoming';
}

@:forward
abstract Discord (InternalDiscord) {
	public function new(options:DiscordOptions) {
		this = new InternalDiscord(options);
	}
	
	public function botAuthLink(opts:{var permissions:Array<DiscordPermission>; @:optional var requireCodeGrant:Bool; @:optional var redirectUri:String; @:optional var scope:DiscordOAuth2Scope; }) {
		var permRes = 0;
		for (p in opts.permissions) permRes |= p;
		var url = 'https://discordapp.com/oauth2/authorize?client_id=' + this.id + '&scope=' + (opts.scope == null ? 'bot' : opts.scope) + '&permissions=' + permRes;
		if (opts.requireCodeGrant != null && opts.requireCodeGrant) url += '&esponse_type=code';
		if (opts.redirectUri != null) url += '&redirect_uri=' + StringTools.urlEncode(opts.redirectUri);
		return url;
	}
	
	public inline function sendMessage(opts:{var to:String; @:optional var message:String; @:optional var tts:Bool; @:optional var nonce:Int; @:optional var typing:Bool; @:optional var embed:DiscordEmbedMessage; }, callback:Error -> DynamicAccess<Dynamic> -> Void) {
		var fields = new Array<DynamicAccess<Dynamic>>();
		for (f in opts.embed.fields) {
			var newf = new DynamicAccess<Dynamic>();
			newf.set('name', f.name);
			newf.set('value', f.value);
			newf.set('inline', f.isInline);
			fields.push(newf);
		}
		var newembed = {
			author: opts.embed.author,
			color: opts.embed.color,
			description: opts.embed.description,
			fields: fields,
			thumbnail: opts.embed.thumbnail,
			title: opts.embed.title,
			timestamp: opts.embed.timestamp,
			url: opts.embed.url,
			footer: opts.embed.footer
		};
		this.sendMessage({
			to: opts.to,
			message: opts.message,
			tts: opts.tts,
			nonce: opts.nonce,
			typing: opts.typing,
			embed: newembed
		}, callback);
	}
}