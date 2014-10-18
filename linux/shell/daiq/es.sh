
############################
#git,repo
function qpush() {
    git push caf HEAD:refs/for/$1
}

function qpushmaster() {
    git push caf HEAD:refs/for/master
}

function qpushgjb_1930_v001() {
    git push caf HEAD:refs/for/gjb_1930_v001
}

function qpushgjb_193503a_v002() {
    git push caf HEAD:refs/for/gjb_193503a_v002
}

