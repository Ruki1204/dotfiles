#---------------------------------------------------
#---------------------基本設定----------------------
#---------------------------------------------------

 bindkey -v # Vimライクな操作にする

 autoload -U compinit; compinit # 補完機能を有効にする 

 setopt auto_cd # 自動cdを有効

# 3つ上層階層に戻ることができる
 alias ...='cd ../..'
 alias ....='cd ../../..'

# cd した先をディレクトリスタックに追加する
 setopt auto_push #cd+<Tab>でスタック履歴を表示

# pushd したとき、ディレクトリがすでにスタックに含まれていればスタックに追加しない
setopt pushd_ignore_dups

 setopt extended_glob # 拡張glabを有効にする

 setopt hist_ignore_all_dups #コマンド履歴の重複を削除

 setopt hist_ignore_space #スペースで始まるコマンドを履歴に追加しない

 zstyle ':completion:*:default' menu select=1 #補完後候補からパス名を選ぶことができる

 WORDCHARS='*?_-.[]~=&;!#$%^(){}<>' #文字コーディングを指定
