txd = engineLoadTXD("Viatura.txd", 490 )
engineImportTXD(txd, 490)
dff = engineLoadDFF("Viatura.dff", 490 )
engineReplaceModel(dff, 490)