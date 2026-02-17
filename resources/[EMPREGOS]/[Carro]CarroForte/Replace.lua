txd = engineLoadTXD("securicar.txd")
engineImportTXD(txd, 428)
dff = engineLoadDFF("securicar.dff", 428)
engineReplaceModel(dff, 428)