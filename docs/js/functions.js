function initBT() {
    let langBtn = document.getElementById('switchLang__btn')
    let en = document.getElementById('subject--en')
    let sk = document.getElementById('subject--sk')
    en.style.display = 'block'
    sk.style.display = 'none'
    langBtn.innerHTML = 'in Slovak'

    let sourcesOld = document.getElementById('sources--old')
    let sourcesTheses = document.getElementById('sources--theses')
    let sourcesExisting = document.getElementById('sources--existing')
    let sourcesTutorials = document.getElementById('sources--tutorials')
    sourcesOld.style.display = 'block'
    sourcesTheses.style.display = 'none'
    sourcesExisting.style.display = 'none'
    sourcesTutorials.style.display = 'none'
}

function switchLang() {
    let btn = document.getElementById('switchLang__btn')
    let en = document.getElementById('subject--en')
    let sk = document.getElementById('subject--sk')

    if (sk.style.display === 'block') {
        sk.style.display = 'none'
        en.style.display = 'display'
        btn.innerHTML = 'in Slovak'
    } else {
        sk.style.display = 'block'
    }

    if (en.style.display === 'block') {
        en.style.display = 'none'
        sk.style.display = 'block'
        btn.innerHTML = 'in English'
    } else {
        en.style.display = 'block'
    }
}

function switchSourcesOld() {
    let sourcesOld = document.getElementById('sources--old')
    let sourcesTheses = document.getElementById('sources--theses')
    let sourcesExisting = document.getElementById('sources--existing')
    let sourcesTutorials = document.getElementById('sources--tutorials')
    sourcesOld.style.display = 'block'
    sourcesTheses.style.display = 'none'
    sourcesExisting.style.display = 'none'
    sourcesTutorials.style.display = 'none'
}
function switchSourcesTheses() {
    let sourcesOld = document.getElementById('sources--old')
    let sourcesTheses = document.getElementById('sources--theses')
    let sourcesExisting = document.getElementById('sources--existing')
    let sourcesTutorials = document.getElementById('sources--tutorials')
    sourcesOld.style.display = 'none'
    sourcesTheses.style.display = 'block'
    sourcesExisting.style.display = 'none'
    sourcesTutorials.style.display = 'none'
}

function switchSourcesExisting() {
    let sourcesOld = document.getElementById('sources--old')
    let sourcesTheses = document.getElementById('sources--theses')
    let sourcesExisting = document.getElementById('sources--existing')
    let sourcesTutorials = document.getElementById('sources--tutorials')
    sourcesOld.style.display = 'none'
    sourcesTheses.style.display = 'none'
    sourcesExisting.style.display = 'block'
    sourcesTutorials.style.display = 'none'
}

function switchSourcesTutorials() {
    let sourcesOld = document.getElementById('sources--old')
    let sourcesTheses = document.getElementById('sources--theses')
    let sourcesExisting = document.getElementById('sources--existing')
    let sourcesTutorials = document.getElementById('sources--tutorials')
    sourcesOld.style.display = 'none'
    sourcesTheses.style.display = 'none'
    sourcesExisting.style.display = 'none'
    sourcesTutorials.style.display = 'block'

}