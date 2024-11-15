
#gftools builder sources/config.yaml 
#gftools builder sources/config-italic.yaml 

cd custom
ln -sfn ../fonts fonts

# all my font files
# sed 's/Nigggli-//g' | 
AMFF=$(ls -1 fonts/otf | sed 's/.otf//g' | tr '\n' ' ')


echo '-- Links for Readme.md file'

for i in $AMFF ; do 
  echo "![Sample Image](documentation/image-"${i}".png)"
done

#@font-face { font-family: Nigggli-CondensedRegular; src: url("../fonts/otf/Nigggli-CondensedRegular.otf"); }
for i in $AMFF ; do 
  echo "@font-face { font-family: "${i}"; src: url(\"../fonts/otf/"${i}".otf\"); }"
done

echo '-- create png preview images'

for i in $AMFF ; do 
  echo "$i"
  node scripts/printImage.js images/Image.html ../fonts/otf/$i.otf ../documentation/image-$i.png
done


echo '-- create specimen for documentation'

node scripts/print.js specimen/Specimen.html
node scripts/print.js specimen/Etik.html
node scripts/print.js specimen/Brentano.html
node scripts/print.js specimen/Woolf.html
node scripts/print.js specimen/Dumas.html
node scripts/print.js specimen/Adamson.html
node scripts/print.js specimen/Endrődi.html
node scripts/print.js specimen/Heisenberg.html

# mv specimen/*.pdf ../documentation

echo '-- create pdfs for tests'

mkdir ../out/qa

for i in $AMFF ; do 
  node scripts/print.js qa/Glyphs.html ../fonts/otf/$i.otf ../out/qa/1-Glyphs-$i.pdf
  node scripts/print.js qa/Spacing.html ../fonts/otf/$i.otf ../out/qa/2-Spacing-$i.pdf
  node scripts/print.js qa/Kerning.html ../fonts/otf/$i.otf ../out/qa/3-Kerning-$i.pdf
  node scripts/print.js qa/Frequency.html ../fonts/otf/$i.otf ../out/qa/4-Frequency-$i.pdf
  node scripts/print.js qa/Kafka.html ../fonts/otf/$i.otf ../out/qa/5-Kafka-$i.pdf
  node scripts/print.js qa/News.html ../fonts/otf/$i.otf ../out/qa/6-News-$i.pdf
  node scripts/print.js qa/Diacritics.html ../fonts/otf/$i.otf ../out/qa/7-Diacritics-$i.pdf
done


cd ..
