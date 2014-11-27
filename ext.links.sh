cd materials

for id in `ls`
do
	id=`echo $id | tr '[:upper:]' '[:lower:]'`
	pre=`echo $id | cut -d. -f1`
	app=`echo $id | cut -d. -f2`
	grep -lr $pre"\."$app * | cut -d '/' -f1 | xargs echo $id:
done

cd ..
