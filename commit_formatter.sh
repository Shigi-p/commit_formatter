#!/bin/sh
commit_type=("[add]" "[update]" "[fix]" "[refactor]" "[document]" "[style]" "[remove]" "[emoji]")

echo "1 [add]     : ファイルの追加"
echo "2 [update]  : コード・機能の追加"
echo "3 [fix]     : コード・機能の修正"
echo "4 [refactor]: コードのリファクタリング"
echo "5 [document]: ドキュメント系の編集 "
echo "6 [style]   : コードの動作に影響しない整形等"
echo "7 [remove]  : ファイルの削除"
echo "8 [emoji]   : git emoji"

while :
do
    # https://atmarkit.itmedia.co.jp/ait/articles/1811/28/news003.html
    read -n1 -p "変更の種類を選択してください : " input_commit_type

    echo;

    case "$input_commit_type" in 
        1 )   commit_prefix=${commit_type[0]}
                break;;
        2 )   commit_prefix=${commit_type[1]}
                break;;
        3 )   commit_prefix=${commit_type[2]}
                break;;
        4 )   commit_prefix=${commit_type[3]}
                break;;
        5 )   commit_prefix=${commit_type[4]}
                break;;
        6 )   commit_prefix=${commit_type[5]}
                break;;
        7 )   commit_prefix=${commit_type[6]}
                break;;
        8 )   echo;
                emoji_list=()

                FILE="$(dirname $0)/local_emoji_list.txt"

                if [ -e $FILE ]; then
                    while read line
                    do
                        echo $line
                        emoji_type=`echo $line | grep -Eo :.*:`
                        emoji_list+=($emoji_type)
                    done < $(dirname $0)/local_emoji_list.txt
                else
                    while read line
                    do
                        echo $line
                        emoji_type=`echo $line | grep -Eo :.*:`
                        emoji_list+=($emoji_type)
                    done < $(dirname $0)/emoji_list.txt
                fi

                while :
                do
                    echo;

                    read -p "emojiの種類を選択してください : " input_emoji_type

                    echo;

                    if (( input_emoji_type )); then
                        commit_prefix=${emoji_list[input_emoji_type - 1]}
                        break
                    fi
                done
                break;;
            # https://qiita.com/ko1nksm/items/095bdb8f0eca6d327233
            * ) echo -e "\033[31m[ERROR!]\033[m 正しい値を入力してください" ;;
    esac
done

read -e -p '変更したファイル名、変更箇所等を入力してください(ない場合は改行) : ' input_changed_file

# https://qiita.com/rockhopper/items/bee538ab4c6aabcd6b0f
# https://en.wikibooks.org/wiki/Regular_Expressions/POSIX-Extended_Regular_Expressions
if [[ ${input_changed_file} =~ ^[[:space:]]*$ ]]; then
    input_changed_file=''
else
    input_changed_file="($input_changed_file)"
fi

while :
do
    read -e -p '作業内容のまとめ・作業理由等を入力してください : ' input_summary

    # https://qiita.com/rockhopper/items/bee538ab4c6aabcd6b0f
    # https://en.wikibooks.org/wiki/Regular_Expressions/POSIX-Extended_Regular_Expressions
    if [[ ${input_summary} =~ ^[[:space:]]*$ ]]; then
        # https://qiita.com/ko1nksm/items/095bdb8f0eca6d327233
        echo -e "\033[31m[ERROR!]\033[m 作業内容のまとめ・作業理由等が入力されていません！"
        input_summary=''
    else
        break
    fi
done

# if [ ]; then;
if [ "$input_changed_file" = "" ]; then
    commit_message="${commit_prefix} $input_summary"
else
    commit_message="${commit_prefix} $input_changed_file $input_summary"
    echo commit_message
fi

echo;

git status

echo;

echo $commit_message

git commit -m "${commit_message}"
