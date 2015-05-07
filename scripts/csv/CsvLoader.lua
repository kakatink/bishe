--
-- Author: 张伟超
-- Date: 2014-08-07 
--
local CsvLoader = {
	configs = {
		["elementCsv"] = { parser = "ElementCsv", file = "csvRes/element.csv"},
		["heroCsv"] = { parser = "HeroCsv", file = "csvRes/hero.csv"},
		["rankCsv"] = { parser = "RankCsv", file = "csvRes/rank.csv"},
		["meritsCsv"] = { parser = "MeritsCsv", file = "csvRes/merits.csv"},
		["skillCsv"] = { parser = "SkillCsv", file = "csvRes/skill.csv"},
		["bossAppearCsv"] = { parser = "BossAppearCsv", file = "csvRes/boss_appear.csv"},
		["bossCsv"] = { parser = "BossCsv", file = "csvRes/boss.csv"},
		["bossSkillCsv"] = { parser = "BossSkillCsv", file = "csvRes/boss_skill.csv"},
		["defaultHeroCsv"] = { parser = "DefaultHeroCsv", file = "csvRes/default_hero.csv"},
		["defaultPlayerCsv"] = { parser = "DefaultPlayerCsv", file = "csvRes/default_player.csv"},
		["defaultEquipCsv"] = { parser = "DefaultEquipCsv", file = "csvRes/default_equip.csv"},
		["defaultNatureCsv"] = { parser = "DefaultNatureCsv", file = "csvRes/default_nature.csv"},
		["chapterCsv"] = { parser = "ChapterCsv", file = "csvRes/chapter.csv"},
		["missionDescCsv"] = { parser = "MissionDescCsv", file = "csvRes/mission_desc.csv"},
		-- ["equipsCsv"] = { parser = "EquipsCsv", file = "csvRes/equips.csv"},
		["missionDialogueCsv"] = { parser = "MissionDialogueCsv", file = "csvRes/mission_dialogue.csv"},
		["missionSettingCsv"] = { parser = "MissionSettingCsv", file = "csvRes/mission_setting.csv"},
		["playerExpCsv"] = { parser = "PlayerExpCsv", file = "csvRes/player_exp.csv"},
		["equipUpNeedCsv"] = { parser = "EquipUpNeedCsv", file = "csvRes/equip_update_needexp.csv"},
		["equipBkNeedCsv"] = { parser = "EquipBreakNeedCsv", file = "csvRes/equip_break_needexp.csv"},
		["equipBkOfferCsv"] = { parser = "EquipBreakOfferCsv", file = "csvRes/equip_break_offerexp.csv"},
		["itemCsv"] = { parser = "ItemCsv", file = "csvRes/item.csv"},
		["mountCsv"] = { parser = "MountCsv", file = "csvRes/mount.csv"},
		["qualityCsv"] = { parser = "QualityCsv", file = "csvRes/quality.csv"},
		["exchangeGoldCsv"] = { parser = "ExchangeGoldCsv", file = "csvRes/exchange_gold.csv"},
		["equipNameCenterCsv"] = { parser = "EquipNameCenterCsv", file = "csvRes/equip_name_center.csv"},
		["equipNameLastCsv"] = { parser = "EquipNameLastCsv", file = "csvRes/equip_name_last.csv"},
		["enchantCsv"] = { parser = "EnchantCsv", file = "csvRes/enchant.csv"},
		["enchantStageCsv"] = { parser = "EnchantStageCsv", file = "csvRes/enchant_stage.csv"},
		["heroUpgradeCsv"] = { parser = "HeroUpgradeCsv", file = "csvRes/hero_upgrade.csv"},
		["randBoxCsv"] = { parser = "RandBoxCsv", file = "csvRes/rand_box.csv"},
		["signCsv"] = { parser = "SignCsv", file = "csvRes/sign.csv"},
		["achievementCsv"] = { parser = "AchievementCsv", file = "csvRes/achievement.csv"},
		["equipShopCsv"] = { parser = "EquipShopCsv", file = "csvRes/equip_shop.csv"},
		["natureScrollCsv"] = { parser = "NatureScrollCsv", file = "csvRes/nature_scroll.csv"},
		["keyBoxCsv"] = { parser = "KeyBoxCsv", file = "csvRes/key_box.csv"},
		["giftCsv"] = { parser = "GiftCsv", file = "csvRes/gift.csv"},
		["heroStageCsv"] = { parser = "HeroStageCsv", file = "csvRes/hero_stage.csv"},
		["equipsNewCsv"] = { parser = "EquipsNewCsv", file = "csvRes/equips_new.csv"},
		["enchantNewCsv"] = { parser = "EnchantNewCsv", file = "csvRes/enchant_new.csv"},
		["shopCsv"] = { parser = "ShopCsv", file = "csvRes/shop.csv"},
		["giftShopCsv"] = { parser = "GiftShopCsv", file = "csvRes/gift_shop.csv"},
		["playerAttributeCsv"] = { parser = "PlayerAttributeCsv", file = "csvRes/player_attribute.csv"},
		["exchangeCsv"] = { parser = "ExchangeCsv", file = "csvRes/exchange_gold.csv"},
	},
}

function CsvLoader.loadCsv()

	for name, data in pairs(CsvLoader.configs) do
		_G[name] = require("csvmodel." .. data.parser)
		_G[name]:load(data.file)
	end
end

return CsvLoader


