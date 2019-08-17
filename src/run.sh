SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd "$SCRIPT_DIR"

# バックアップ＆リストア
sqlite3 :memory: \
"create table T(C text);" \
"insert into T values('A');" \
"select * from T;" \
".backup ./some.backup"

sqlite3 :memory: \
".restore ./some.backup" \
"select * from T;"

# リストアすると元のテーブルやデータは全部消える！
sqlite3 :memory: \
"create table Z(C text);" \
"insert into Z values('Z');" \
".tables" \
"select * from Z;" \
".restore ./some.backup" \
".tables" \
"select * from T;"

