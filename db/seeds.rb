# def get_contests
#   uri = URI.parse(URI.encode "https://kenkoooo.com/atcoder/resources/contests.json")
#   result = call_api(uri)
# end

# def get_problems
#   uri = URI.parse(URI.encode "https://kenkoooo.com/atcoder/resources/problems.json")
#   result = call_api(uri)
# end

# def create_submissions(atcoder_user)
#   if atcoder_user.submissions.empty?
#     submissions = atcoder_user.get_submissions
#     submissions_list = []
#     submissions.each do |submission|
#       submissions_list << 
#       atcoder_user.submissions.build(
#         number: submission["id"],
#         epoch_second: submission["epoch_second"],
#         problem_name: submission["problem_id"],
#         contest_name: submission["contest_id"],
#         language: submission["language"],
#         point: submission["point"],
#         result: submission["result"]
#       )
#     end
#     Submission.import! submissions_list
#   end
# end

# def call_api(uri)
#   sleep 1
#   https = Net::HTTP.new(uri.host, uri.port)
#   https.use_ssl = true
#   res = https.start do
#     https.get(uri.request_uri)
#   end
#   if res.code == '200'
#     result = JSON.parse(res.body)
#   else
#     # puts "#{res.code} #{res.message}"
#     # puts "No such user_id"
#     # puts "test"
#     # exit 1
#   end
# end

# contests = get_contests
# contest_list = []
# contests.each do |contest|
#   contest_list << 
#   Contest.new(
#     name: contest["id"],
#     start_epoch_second: contest["start_epoch_second"],
#     duration_second: contest["duration_second"],
#     title: contest["title"],
#     rate_change: contest["rate_change"]
#   )
# end
# Contest.import contest_list

# problems = get_problems
# problem_list = []
# problems.each do |problem|
#   problem_list << 
#   Problem.new(
#     name:  problem["id"],
#     title: problem["title"],
#     contest_name:  problem["contest_id"]
#   )
# end
# Problem.import problem_list

chokudai = AtcoderUser.find_or_create_atcoder_user("chokudai")
testusers = ["chokudai", "ose20", "nibosea", "mhrb", "mencotton", "otamay", "ChiyosBigDragon", "tokumini", "m_99", "ameise", "Trietta", "olphe", "Rubikun", "Mojumbo", "xuzijian629", "kichi2004", "KKT89", "gamino", "naotooct25", "jupiro", "petite_prog", "ntk_ta01", "NOSS", "side", "iLoveSakurakoEA", "beet", "Lily0727K", "karasuex54", "snow39", "SilverHammer", "maspy", "FAIO1230", "tatyam", "niuez", "yuto953", "gyuudonn1222", "brightcat", "you070707", "drken", "coco18000", "tokizo", "sbite", "nu50218", "dn6049949", "hpp", "tk555", "Regent_50m", "shinchan", "anon565656", "miiifa", "ate", "takenoko2940", "shop_one", "sakaki_tohru", "ir_1st_vil", "akun0716", "rokahikou", "TShima634", "one0803", "juppy", "bin101", "kyon2326", "noshi91", "ui_mtc", "yi7242", "mayu__p", "hase", "edamat", "sifi_border", "qLethon", "totori_nyaa", "Dotter", "ikasashi", "holeguma", "torokon", "kuretchi", "ibuki2003", "qsako6", "horiso0921", "shugo256", "ush", "Example", "saba", "maru65536", "nanika", "yu5shi8", "KNOT", "chocobo", "earlgray283", "kibuna", "tourist", "Yama24", "oldlick", "ikanago", "kayokayo", "mo3tthi", "Emmy_Masao", "ebi_fly", "ika__si", "kyou_syansyan", "nesya", "muatotto", "myabu", "snowbird315", "sumochi", "tenba", "wanwan0622", "zero_kpr", "MNishida1992", "Suhe", "koyamaso", "cbox360", "golgi", "maiodoru_hime", "SPD_9X2", "wattaihei", "nushore", "snoowty", "leafirby", "maple_f", "kaage", "KoD", "define", "MZKi", "hexa0611", "mugen1337", "kyomukyomupurin", "Lorse", "face4", "geoanalysis", "peco0901", "cumin", "Roy_R", "kumpy", "toto61", "alfaromeo4c", "mutuhuhihusenonu", "tkt989", "HayatoY", "kimiyuki", "harady", "sanadayukimura73", "tamurin", "th90tk297", "uriri", "Morifo", "kort0n", "seriru", "yamasaKit", "MizukiHashimoto", "rkakamilan", "kafuka97", "phocom", "Haa", "masa6372", "kakira", "koikotya", "mine691", "rsk0315", "kens", "tozangezan", "wisteria0410ss", "apiad", "ksun48", "phystak", "LHiC", "yutaka1999", "cospleermusora", "vepifanov", "eatmore", "morio__", "patrickticktock", "Mille", "oden6680", "kanekyo", "yukishiba", "Petr", "iica", "suika_p", "null0124", "Kats", "Hyado", "toririm", "risujiroh", "x0214sh7", "ferin_tech", "tonets", "TAB", "hibatibati", "homesentinel", "treeone", "metaerr", "galileo15640215", "TAISA_", "ast210", "Tsubame", "Teru_3", "ecto0310", "ei13333", "latte0119", "ryskchy", "Um_nik", "Egor", "XXXHOLiC", "tklab", "Atria", "iehn", "yaketake08", "firiexp", "satanic0258", "mnbvmar", "Marcin", "Stonefeang", "jcvb", "Benq", "Swistakk", "tute7627", "ziroppe", "Nishi3311", "arounderstand", "ronshin", "yukiotk", "alipay", "ttttan", "kottan38", "omusubi", "ekaraage", "Engelcat", "HaveFunWP", "ralt", "klno", "zaki1236", "TakoKurage", "kuhaku", "HowaitoY", "Tsuta_J", "theory_and_me", "keymoon", "maze1230", "Tqk", "auaua", "ynymxiaolongbao", "centipede_human", "sheyasutaka", "FSM", "mmnk_atcoder", "dividebyzero", "KumaRyo4611", "likr", "tomohiro_yamaguc", "fm19991129", "Zu_rin", "jj_", "CleyL", "seica", "yuma220284", "chittai", "takkii", "Toshio", "muscat", "TMJN", "DisGrowth", "Higurashi", "kobaryo222", "kibi62", "nayuta9999", "qfiighter", "matsuba", "tyawanmusi", "zurukumo", "SatsukiFlat", "hir35", "Ryo2016", "June_boy", "Sashiming", "Sakkrai", "aya_se", "rat", "maroonrk", "hos_lyric", "kamijodev", "simkaren", "arc", "ecasdqina", "Libra_A", "ikatakos", "nagiss", "simamumu", "okumura", "hoxosh", "ukikagi", "nwin", "Kiri8128", "anagohirame", "shakayami", "titia", "onakasuitacity", "su_565fx", "anmichi", "sk4rd", "heno239", "yuji9511", "OtsuKotsu", "yamake", "lpuwfob", "inoudayo", "penbmn", "betrue12", "kenkoooo", "Series_205", "fetburner", "kirimin", "komura314", "jjjjjjjtgpptmjj", "Bondo416", "asdf1", "adomine", "primenumber", "Maasin", "bookbibi", "toku", "hdrop", "sei1tani", "Reborn_K", "kenken714", "rajyan", "sarashin", "readonly_true", "p4sobaya", "prd_xxx", "mdstoy", "Bantako", "colorbox", "Motsu_xe", "lynmisakura", "suzuken_w", "semiexp", "ngtkana", "hiramekun", "kotatsugame", "RTnF", "square1001", "b2563125", "autumn_eel", "naoki2016", "QCFium", "spica314", "Div9851", "sakura873", "miscalculation53", "champon", "AokabiC", "reverd", "SIGSEGV", "moririn2528", "atzou", "ecnerwal", "Lilkoke11", "ttjapan", "convexineq", "uwi", "wkb89_", "ward1302", "otera", "tran0826", "miyuki_y", "suisoo", "pyonth", "Ricky_pon", "Nakamoto17", "kyawa", "testes89", "yamunaku", "noimi", "mitsuki_AC", "momohara", "zezero", "Apple_Boy", "tubuann", "Yu_212", "onigawara", "zln", "Utopiosphere", "tinatora", "sonata", "potate", "tRue", "alexara1123", "Suunn", "hamko", "dama_math", "noppiyy", "tempura0224", "tomarint", "knk_kei", "Shibuyap", "Namu3", "A0I", "UME7", "Osmium_1008", "Thistle", "i8nd5t", "hotman78", "ganariya2525", "kuroku_969", "kawap23", "chocopuu", "bored_funuke", "Noiri", "oevl", "Noimin", "idsigma", "mizukurage", "socha", "ijm", "ikd", "bachoppi", "nohtaray", "yosupo", "DEGwer", "sugim48", "asumoking", "gemmaro", "tatsumack", "ningenMe", "siro53", "eSeF", "y61mpnl", "tako0218", "YDK_NK", "ei1923", "k_k_hiroki", "dn154", "baku1101", "shibh308", "yokoyan", "ue_sho", "Tritama", "Shiro_S", "pynomi", "fellp1", "Imperi", "Ricky_Ban", "tamaron", "lucky3977", "zer0star", "mola1129", "shi", "temmie", "kita889", "nope124", "nagitaosu", "Algae_peroxide", "lemon_", "fshuto", "snuke", "proproping", "cunitac", "txaik", "HU_Ryusei", "mototakashi", "masa_aa", "LiEat_D", "hitokage8000", "seikei135do", "piddy", "kishirasuku", "sash", "phyllo", "knk", "Flkanjin", "Aotsuki_", "laft", "arktan763", "miotsukushi", "Hasegawa_frog", "Dente", "dazhong_feliks", "naoppy", "reud", "kanade9", "yanagi3150", "NaomiatLibrary", "lowking", "yahoobb", "yta_smh17", "physics0523", "luma", "kotamanegi", "rniya", "c_r_5", "mint", "Lafolia", "Iwancof", "ktnyori", "i1ain2", "zenpachi", "severrabaen", "ttm8761", "MMNMM", "drogskol", "keep_OC", "fukubutyo", "Shizuku", "kota_hkd", "outline", "izumo", "Shuzaei", "jell", "punipuni", "ringokuppa", "bokuzin", "Gizerst", "delta71", "inonoa", "TKO", "cirno3153", "krn7", "gaku95", "roto_37", "abc050", "Tallfall", "gojira_ku", "nicolen", "wtrgjadmw", "makecir", "edamame88", "cot57", "nayuta", "leaf1415", "Harry325Kitajima", "r1933", "ei1903", "ccppjsrb", "penguinman", "AItale", "tanishi", "tetsuro1919", "kagasan", "hrbt", "mizuki", "kyuridenamida", "to_higher", "popketle", "baito", "capellakoma", "plcherrim", "shift0", "Sp_East", "batsumaru", "tomomo2b2", "yupiteru", "tanzaku", "neterukun", "cis_yuta", "kazunami", "Ta910", "hals", "tatuyahyahya", "sano_IQ3", "Naochi", "kkrr", "urayamakoutarou", "kobasato33", "ksera322", "mito1213", "soshun", "addeight", "diohabara", "tanishi14", "kazuma", "alumina_8", "akiozi", "lucky_space", "E869120", "Zaurus", "tac_", "kyuna", "kya", "ha191180", "kmjp", "zeke", "kuma842", "syun21", "TJku", "Ti11192916", "Flores", "ngs", "Palace_palace", "yumaru", "takayg", "yoppepro", "math", "ikkun2501", "Doit", "sh_mug", "Bwambocos", "Kenkenkaij", "yuta28", "KGftohas", "l_h_e", "phos", "zundamochi_1117", "spawn", "tarattata", "goldponnana", "jhonson1415", "NOSHION", "kanpurin", "monkukui", "null_null", "naradatsu", "jj1guj", "yotsutose", "ryota101020", "kasumi76", "medo1005", "Coffeemilk_8610", "ninoi", "tmg_dayo", "yoshinGO", "cashisu1", "purine", "kitagawa1992", "blue_jam", "da_louis", "rutilicus", "shibamata", "softbear", "irohasu555", "sakaki", "pori_na", "Sen", "hope_ton94", "hakusye", "Dougubako", "NASSUN_ei1906", "yonetin", "torisasami", "syunsuke", "takeo", "krn_7", "siman", "itigo", "daikisuyama", "yuta0210", "isawo", "Freddy_me_me2", "greatj", "ryota", "yk26tan", "bustle0309", "tomozow", "mottsu", "ei1918", "ei1941", "yuki819", "zeronosu77108", "Cer0un0", "nog", "yuruhiya", "mahala_coder", "jintaku", "ponponpainful", "toame", "Ichijyo", "rinrion", "unos", "ysystem", "iamaneet", "hirotaku", "salad_bar", "GOI", "V_Melville", "denden12", "aoharu514", "black9", "nishiwakki", "Gear", "parsee1053", "yumsiim", "HIROSHI0635", "toot_tatsuhiro", "yasufumy", "xyz600", "fish0504", "seeking", "gomatamago", "satory074", "yuya3542", "hkawaguc", "ats5515", "joisino", "crom", "gghatano", "ganden", "KY2001", "mimitch", "miiverse_udon", "udon", "iwaiwaiwa", "Mitsubachi", "tada72", "kohdai", "sphere_m", "Ratih", "tman", "watarimaycry2", "AndrewK", "nrvft", "musuchika", "naichilab", "one23", "Akaeri", "yuk23i", "rnazmo", "Nanigasi_san", "lockdef", "Ebishu0309", "seven_three", "appletimes", "nuhunune", "m_9719", "rstoick", "erniogi", "blackyuki", "THEokimiso", "C_nena_E", "cleantted", "hiratai", "sueki", "T_M", "lip1000kg", "okkuu2", "boutarou", "goemon0454", "Peroxide", "tdtk", "tamasho", "yoshnary", "nicklaw296", "akariki", "shiita0903", "Ry0um4", "ToM_ynu", "tmsick", "FeLvi", "nebusoku__", "hiku", "masken", "b1464296", "ksk6348", "M4c4r0n", "xryuseix", "tmaehara", "kawara_y", "murin", "octo", "Nekorinrin"]
testusers.each do |user|
  AtcoderUser.find_or_create_atcoder_user(user)
end
# create_submissions(chokudai)

User.create!(
  user_name:  "Example User",
  uid: "12345",
  provider:  "twitter",
  image_url: "icon.png",
  atcoder_user_id: 1
)

Crawler.get_contests
Crawler.get_problems
Crawler.get_histories