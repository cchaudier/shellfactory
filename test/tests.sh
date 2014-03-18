for fic_test in $(ls -1 *.bats); do
    echo "Lancement des tests $fic_test"
    bats $fic_test
done
