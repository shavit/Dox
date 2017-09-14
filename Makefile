api: app/Dockerfile postgis
	@echo "---> Compile the API"
	@docker stop app_api || true
	@export GOOS=linux
	export DATABASE_URI=postgres://postgres:postgres@172.17.0.1/geocoder?sslmode=disable
	docker build --file app/Dockerfile ${PWD}/app -t app_api
	docker run --rm --name app_api -td app_api
	docker exec -ti app_api go test app
	docker exec -ti app_api go build -o bin/app app
	@echo "---> Run: docker exec -ti app_api app [adddress]\nto geocode an address"

postgis:
	@echo "---> Running the PostGIS image from moofish32/postgis-geocoder"
	@docker stop postgis || true
	@docker rm postgis || true
	mkdir -p ${PWD}/data/gis
	mkdir -p ${PWD}/data/pg
	docker run --name postgis -p 5432:5432 \
		-v ${PWD}/data/gis:/gisdata \
		-v ${PWD}/data/pg:/var/lib/postgresql/data \
		-td moofish32/postgis-geocoder
	docker stop postgis
	echo "checkpoint_segments = 60" >> ${PWD}/data/pg/postgresql.conf
	echo "checkpoint_timeout = 45min" >> ${PWD}/data/pg/postgresql.conf
	docker start postgis

	docker exec -t postgis bash /gisdata/nation.sh
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/AL.sh -A -t -c "SELECT loader_generate_script(ARRAY['AL'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/AK.sh -A -t -c "SELECT loader_generate_script(ARRAY['AK'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/AZ.sh -A -t -c "SELECT loader_generate_script(ARRAY['AZ'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/AR.sh -A -t -c "SELECT loader_generate_script(ARRAY['AR'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/CA.sh -A -t -c "SELECT loader_generate_script(ARRAY['CA'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/CO.sh -A -t -c "SELECT loader_generate_script(ARRAY['CO'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/CT.sh -A -t -c "SELECT loader_generate_script(ARRAY['CT'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/DC.sh -A -t -c "SELECT loader_generate_script(ARRAY['DC'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/DE.sh -A -t -c "SELECT loader_generate_script(ARRAY['DE'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/FL.sh -A -t -c "SELECT loader_generate_script(ARRAY['FL'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/GA.sh -A -t -c "SELECT loader_generate_script(ARRAY['GA'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/HI.sh -A -t -c "SELECT loader_generate_script(ARRAY['HI'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/ID.sh -A -t -c "SELECT loader_generate_script(ARRAY['ID'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/IL.sh -A -t -c "SELECT loader_generate_script(ARRAY['IL'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/IN.sh -A -t -c "SELECT loader_generate_script(ARRAY['IN'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/IA.sh -A -t -c "SELECT loader_generate_script(ARRAY['IA'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/KS.sh -A -t -c "SELECT loader_generate_script(ARRAY['KS'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/KY.sh -A -t -c "SELECT loader_generate_script(ARRAY['KY'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/LA.sh -A -t -c "SELECT loader_generate_script(ARRAY['LA'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/ME.sh -A -t -c "SELECT loader_generate_script(ARRAY['ME'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/MD.sh -A -t -c "SELECT loader_generate_script(ARRAY['MD'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/MA.sh -A -t -c "SELECT loader_generate_script(ARRAY['MA'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/MI.sh -A -t -c "SELECT loader_generate_script(ARRAY['MI'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/MN.sh -A -t -c "SELECT loader_generate_script(ARRAY['MN'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/MS.sh -A -t -c "SELECT loader_generate_script(ARRAY['MS'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/MO.sh -A -t -c "SELECT loader_generate_script(ARRAY['MO'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/MT.sh -A -t -c "SELECT loader_generate_script(ARRAY['MT'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/NE.sh -A -t -c "SELECT loader_generate_script(ARRAY['NE'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/NV.sh -A -t -c "SELECT loader_generate_script(ARRAY['NV'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/NH.sh -A -t -c "SELECT loader_generate_script(ARRAY['NH'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/NJ.sh -A -t -c "SELECT loader_generate_script(ARRAY['NJ'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/NM.sh -A -t -c "SELECT loader_generate_script(ARRAY['NM'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/NY.sh -A -t -c "SELECT loader_generate_script(ARRAY['NY'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/NC.sh -A -t -c "SELECT loader_generate_script(ARRAY['NC'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/ND.sh -A -t -c "SELECT loader_generate_script(ARRAY['ND'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/OH.sh -A -t -c "SELECT loader_generate_script(ARRAY['OH'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/OK.sh -A -t -c "SELECT loader_generate_script(ARRAY['OK'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/OR.sh -A -t -c "SELECT loader_generate_script(ARRAY['OR'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/PA.sh -A -t -c "SELECT loader_generate_script(ARRAY['PA'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/RI.sh -A -t -c "SELECT loader_generate_script(ARRAY['RI'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/SC.sh -A -t -c "SELECT loader_generate_script(ARRAY['SC'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/SD.sh -A -t -c "SELECT loader_generate_script(ARRAY['SD'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/TN.sh -A -t -c "SELECT loader_generate_script(ARRAY['TN'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/TX.sh -A -t -c "SELECT loader_generate_script(ARRAY['TX'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/UT.sh -A -t -c "SELECT loader_generate_script(ARRAY['UT'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/VT.sh -A -t -c "SELECT loader_generate_script(ARRAY['VT'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/VA.sh -A -t -c "SELECT loader_generate_script(ARRAY['VA'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/WA.sh -A -t -c "SELECT loader_generate_script(ARRAY['WA'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/WV.sh -A -t -c "SELECT loader_generate_script(ARRAY['WV'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/WI.sh -A -t -c "SELECT loader_generate_script(ARRAY['WI'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -o /gisdata/states/WY.sh -A -t -c "SELECT loader_generate_script(ARRAY['WY'], 'geocoder') AS result;"
	docker exec -t postgis psql -U postgres -d geocoder -c "SELECT install_missing_indexes();"

download: postgis
	mkdir -p ${PWD}/run
	docker exec -t postgis for f in states/*.sh
	docker exec -t postgis sh /gisdata/states/AL.sh && echo $$ > $PWD/run/AL_pid
	docker exec -t postgis sh /gisdata/states/AK.sh && echo $$ > $PWD/run/AK_pid
	docker exec -t postgis sh /gisdata/states/AZ.sh && echo $$ > $PWD/run/AZ_pid
	docker exec -t postgis sh /gisdata/states/AR.sh && echo $$ > $PWD/run/AR_pid
	docker exec -t postgis sh /gisdata/states/CA.sh && echo $$ > $PWD/run/CA_pid
	docker exec -t postgis sh /gisdata/states/DC.sh && echo $$ > $PWD/run/DC_pid
	docker exec -t postgis sh /gisdata/states/CO.sh && echo $$ > $PWD/run/CO_pid
	docker exec -t postgis sh /gisdata/states/CT.sh && echo $$ > $PWD/run/CT_pid
	docker exec -t postgis sh /gisdata/states/DE.sh && echo $$ > $PWD/run/DE_pid
	docker exec -t postgis sh /gisdata/states/FL.sh && echo $$ > $PWD/run/FL_pid
	docker exec -t postgis sh /gisdata/states/GA.sh && echo $$ > $PWD/run/GA_pid
	docker exec -t postgis sh /gisdata/states/HI.sh && echo $$ > $PWD/run/HI_pid
	docker exec -t postgis sh /gisdata/states/ID.sh && echo $$ > $PWD/run/ID_pid
	docker exec -t postgis sh /gisdata/states/IL.sh && echo $$ > $PWD/run/IL_pid
	docker exec -t postgis sh /gisdata/states/IN.sh && echo $$ > $PWD/run/IN_pid
	docker exec -t postgis sh /gisdata/states/IA.sh && echo $$ > $PWD/run/IA_pid
	docker exec -t postgis sh /gisdata/states/KS.sh && echo $$ > $PWD/run/KS_pid
	docker exec -t postgis sh /gisdata/states/KY.sh && echo $$ > $PWD/run/KY_pid
	docker exec -t postgis sh /gisdata/states/LA.sh && echo $$ > $PWD/run/LA_pid
	docker exec -t postgis sh /gisdata/states/ME.sh && echo $$ > $PWD/run/ME_pid
	docker exec -t postgis sh /gisdata/states/MD.sh && echo $$ > $PWD/run/MD_pid
	docker exec -t postgis sh /gisdata/states/MA.sh && echo $$ > $PWD/run/MA_pid
	docker exec -t postgis sh /gisdata/states/MI.sh && echo $$ > $PWD/run/MI_pid
	docker exec -t postgis sh /gisdata/states/MN.sh && echo $$ > $PWD/run/MN_pid
	docker exec -t postgis sh /gisdata/states/MS.sh && echo $$ > $PWD/run/MS_pid
	docker exec -t postgis sh /gisdata/states/MO.sh && echo $$ > $PWD/run/MO_pid
	docker exec -t postgis sh /gisdata/states/MT.sh && echo $$ > $PWD/run/MT_pid
	docker exec -t postgis sh /gisdata/states/NE.sh && echo $$ > $PWD/run/NE_pid
	docker exec -t postgis sh /gisdata/states/NV.sh && echo $$ > $PWD/run/NV_pid
	docker exec -t postgis sh /gisdata/states/NH.sh && echo $$ > $PWD/run/NH_pid
	docker exec -t postgis sh /gisdata/states/NJ.sh && echo $$ > $PWD/run/NJ_pid
	docker exec -t postgis sh /gisdata/states/NM.sh && echo $$ > $PWD/run/NM_pid
	docker exec -t postgis sh /gisdata/states/NY.sh && echo $$ > $PWD/run/NY_pid
	docker exec -t postgis sh /gisdata/states/NC.sh && echo $$ > $PWD/run/NC_pid
	docker exec -t postgis sh /gisdata/states/ND.sh && echo $$ > $PWD/run/ND_pid
	docker exec -t postgis sh /gisdata/states/OH.sh && echo $$ > $PWD/run/OH_pid
	docker exec -t postgis sh /gisdata/states/OK.sh && echo $$ > $PWD/run/OK_pid
	docker exec -t postgis sh /gisdata/states/OR.sh && echo $$ > $PWD/run/OR_pid
	docker exec -t postgis sh /gisdata/states/PA.sh && echo $$ > $PWD/run/PA_pid
	docker exec -t postgis sh /gisdata/states/RI.sh && echo $$ > $PWD/run/RI_pid
	docker exec -t postgis sh /gisdata/states/SC.sh && echo $$ > $PWD/run/SC_pid
	docker exec -t postgis sh /gisdata/states/SD.sh && echo $$ > $PWD/run/SD_pid
	docker exec -t postgis sh /gisdata/states/TN.sh && echo $$ > $PWD/run/TN_pid
	docker exec -t postgis sh /gisdata/states/TX.sh && echo $$ > $PWD/run/TX_pid
	docker exec -t postgis sh /gisdata/states/UT.sh && echo $$ > $PWD/run/UT_pid
	docker exec -t postgis sh /gisdata/states/VT.sh && echo $$ > $PWD/run/VT_pid
	docker exec -t postgis sh /gisdata/states/VA.sh && echo $$ > $PWD/run/VA_pid
	docker exec -t postgis sh /gisdata/states/WA.sh && echo $$ > $PWD/run/WA_pid
	docker exec -t postgis sh /gisdata/states/WV.sh && echo $$ > $PWD/run/WV_pid
	docker exec -t postgis sh /gisdata/states/WI.sh && echo $$ > $PWD/run/WI_pid
	docker exec -t postgis sh /gisdata/states/WY.sh && echo $$ > $PWD/run/WY_pid
