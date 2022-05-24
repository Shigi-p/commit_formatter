# commit_formatter

## about commit formatter

~~python でコミットメッセージのフォーマットを行うツールを作りました~~

どの環境でもセットアップなしに動いてほしくなってきたので、bash だろうが zsh だろうが fish だろうが動く shell バージョンを追加

```
[commit_prefix] (changed_file_name) changed description
```

こんな形にコミットを整形してくれます

git emoji を使うのがお好みな方は`emoji_list.txt`を参考に`local_emoji_list.txt`ファイルを作成してください

`01 emoji :emoji_name: description for emoji`

みたいなフォーマットで入れれば動くはずです(多分)

## セットアップ

### for bash

```shell script
chmod +x commit_formatter.sh
echo "alias gcommit=\"sh `pwd`/commit_formatter.sh\"" >> ~/.bashrc
source ~/.bashrc
```

### for zsh

```shell script
chmod +x commit_formatter.sh
echo "alias gcommit=\"sh `pwd`/commit_formatter.py\"" >> ~/.zshrc
source ~/.zshrc
```

### for fish

```shell script
chmod +x commit_formatter.sh
echo "abbr -a gcommit 'sh `pwd`/commit_formatter.sh'" >> ~/.config/fish/config.fish
source ~/.config/fish/config.fish
```

`git add`してから`git commit`みたいな感覚でやって`git push`してください
