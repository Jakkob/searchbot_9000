module SearchBot

	module EncoreQueries

		def self.find_people_for_etl(beginning, ending)
		  start_year = beginning
		  end_year = ending

		  encore_query = <<-SQL
		  SELECT ppl.[FirstName] as first_name
		    ,ppl.[LastName] as last_name
		    ,ppl.[GUID] as encore_guid
		    ,ppl.[City] as city
		    ,rgn.[MailingName] as [state]
		    ,YEAR(ppl.[ResumeUpdated]) as resume_year
		    ,cpy.[CompanyName] as last_known_employer
		    ,xp.[OfficialTitle] as last_known_title
		    ,YEAR(xp.[StartDate]) as last_known_start_date
		    ,ppl.[ResumeFile] as resume_link
		    ,ppl.[PeopleDoNotPrint] as dnp_status
		    ,ppl.[TimeUpdated] as last_updated
		  FROM [Encore].[dbo].[tPeople] as ppl
		  LEFT JOIN [Encore].[dbo].[tRegion] as rgn on rgn.[GUID] = ppl.[RegionGUID]
		  LEFT JOIN [Encore].[dbo].[tExperience] as xp on xp.[GUID] = ppl.[CurrentExperienceGUID]
		  LEFT JOIN [Encore].[dbo].[tCompany] as cpy on cpy.[GUID] = xp.[CompanyGUID]
		  WHERE (ppl.[Website] IS NULL OR ppl.[Website] NOT LIKE N'%linkedin%') AND ppl.[ResumeUpdated] >= '01-01-#{start_year}' AND ppl.[ResumeUpdated] < '01-01-#{end_year}'
		  ORDER BY ppl.[ResumeUpdated] asc
		  SQL
		  encore_query.to_s
		end
	end
end